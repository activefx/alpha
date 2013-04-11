module Api
  module V1
    class BaseController < ActionController::Metal

      # Leaner controller stack for API requests
      # See lib/api/controller_setup.rb for more information
      #
      include Api::ControllerSetup

      # Add NewRelic instrumentation for ActionController::Metal
      #
      include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

      # protect_from_forgery

      attr_accessor :current_api_user

      MONTHLY_API_RATE_LIMIT = 10000
      DAILY_API_RATE_LIMIT   = 5000
      HOURLY_API_RATE_LIMIT  = 1000

      ENABLED_RATE_LIMITS = %w(monthly daily hourly)

      API_ERROR_CODES = {
        Api::BadRequest                     => 400,
        Api::Unauthorized                   => 401,
        Api::Forbidden                      => 403,
        CanCan::AccessDenied                => 403,
        Api::RateLimitExceeded              => 403,
        Api::NotFound                       => 404,
        Mongoid::Errors::DocumentNotFound   => 404,
        Api::MethodNotAllowed               => 405,
        Api::NotAcceptable                  => 406,
        Api::Conflict                       => 409,
        Api::UnprocessableEntity            => 422,
        Api::NotImplemented                 => 501,
        Api::ServiceUnavailable             => 503,
        Api::InternalServerError            => 500
      }

      API_FORMATS = [ :json ]

      respond_to *API_FORMATS

      before_filter :skip_trackable
      before_filter :check_api_format!
      before_filter :check_request_action!
      before_filter :authenticate_api_user!
      before_filter :rate_limit_api_requests!

      rescue_from *API_ERROR_CODES.keys, :with => :api_error

      [ :index, :show, :new, :create, :edit, :update, :delete ].each do |method_name|
        self.class_eval do
          define_method :"#{method_name}" do
            raise Api::NotImplemented
          end
        end
      end

      # Register controller actions for NewRelic to monitor
      #
      add_transaction_tracer :index
      add_transaction_tracer :show
      add_transaction_tracer :new
      add_transaction_tracer :create
      add_transaction_tracer :edit
      add_transaction_tracer :update
      add_transaction_tracer :delete

      private

      # If you are using token authentication with APIs and using trackable.
      # Every request will be considered as a new sign in (since there is no
      # session in APIs).
      def skip_trackable
        request.env['devise.skip_trackable'] = true
      end

      # Ensure the API request is made with an allowed data format
      def check_api_format!
        format = params[:format] || params[:default][:format]
        unless format.present? && API_FORMATS.include?(format.to_sym)
          raise Api::NotAcceptable
        end
      end

      # Ensure the API request adhears to restful conventions
      def check_request_action!
        case params[:action]
        when "index"
          raise Api::MethodNotAllowed unless request.get?
        when "show"
          raise Api::MethodNotAllowed unless request.get?
        when "create"
          raise Api::MethodNotAllowed unless request.post?
        when "update"
          raise Api::MethodNotAllowed unless request.put?
        when "delete"
          raise Api::MethodNotAllowed unless request.delete?
        end
      end

      def api_error(exception)
        api_error_response(
          api_status_code(exception),
          api_error_message(exception),
          exception
        )
      end

      def api_status_code(exception)
        API_ERROR_CODES[exception.class]
      end

      def api_error_response(status, explanation, exception = nil)
        if [500].include?(status) && params['action'] != 'status'
          log_api_error(exception)
        end
        render :status => status, :json => { :error => explanation }
      end

      def api_error_message(exception)
        return eval(exception.message) if exception.message =~ /\A\{.*\}\z/
        return Api::NOT_FOUND if exception.class.eql? Mongoid::Errors::DocumentNotFound
        return Api::FORBIDDEN if exception.class.eql? CanCan::AccessDenied
        return exception.message unless exception.message.starts_with? "Api::"
        "Api::#{exception.message.split('::').last.underscore.upcase}".constantize
      end

      def authenticate_api_user!
        find_current_api_user
        ensure_user_exists!
      end

      def find_current_api_user
        @current_api_user = case
        when request.headers["X-Auth-Token"].present?
          user_by_auth_token(request.headers["X-Auth-Token"])
        when request.headers["X-Api-Key"].present?
          user_by_api_key(request.headers["X-Api-Key"])
        when params[:auth_token].present?
          user_by_auth_token(params[:auth_token])
        when params[:api_key].present?
          user_by_api_key(params[:api_key])
        else nil
        end
      end

      def user_by_auth_token(auth_token)
        user = User.where(authentication_token: auth_token).first
        if user && user.auth_token_expired?
          raise Api::Unauthorized,
            'Your session has expired, please sign in again to reauthenticate.'
        end
        user
      end

      def user_by_api_key(api_key)
        User.where('api_keys.token' => api_key).first
      end

      def ensure_user_exists!
        raise Api::Unauthorized if current_api_user.nil?
      end

      def rate_limit_api_requests!
        return if Rails.env.development?
        ENABLED_RATE_LIMITS.each{ |t| check_rate_limit(t) }
      end

      def initialize_rate_limit_cache(time_frame)
        response.headers["X-#{time_frame.capitalize}-Rate-Limit-Remaining"] =
          api_limit(time_frame) - 1
        Rails.cache.write(cache_key(time_frame), 1, :raw => true)
      end

      def api_limit(time_frame)
        current_api_user.send("#{time_frame}_api_rate_limit") ||
        self.class.const_get("#{time_frame.upcase}_API_RATE_LIMIT")
      end

      def cache_key(time_frame)
        "#{current_api_user.id}:" + case time_frame
        when "monthly"  then Time.now.strftime('%Y-%m')
        when "daily"    then Time.now.strftime('%Y-%m-%d')
        when "hourly"   then Time.now.strftime('%Y-%m-%dT%H')
        end.to_s
      end

      def api_calls(time_frame)
        unless instance_variable_get("@#{time_frame}_api_calls")
          instance_variable_set(
            "@#{time_frame}_api_calls",
            Rails.cache.read(cache_key(time_frame)).to_i
          )
        end
      end

      def check_rate_limit(time_frame)
        # Only initialize the cache and return if it is the first api call
        if api_calls(time_frame).eql? 0
          return initialize_rate_limit_cache(time_frame)
        end
        # Send the rate limit error if calls exceed the time frame limit
        if api_calls(time_frame) > api_limit(time_frame)
          raise Api::RateLimitExceeded,
          "You have exceeded your #{time_frame} allotment of API calls"
        end
        # Otherwise just increment the cache
        Rails.cache.increment(cache_key(time_frame))
        response.headers["X-#{time_frame.capitalize}-Rate-Limit-Remaining"] =
          api_limit(time_frame) - api_calls(time_frame)
      end

      def log_api_error(exception)
        case Rails.env
        when "production", "staging"
          notify_airbrake(exception) if defined?(Airbrake)
        when "test"
          puts exception.log_output
        when "development"
          logger.error exception.log_output
        end
      end

    end
  end
end

