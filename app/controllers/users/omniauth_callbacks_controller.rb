module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    skip_before_filter :show_beta_page?

    # /users/auth/:provider/callback
#    def all
#      #raise request.env['omniauth.auth'].to_yaml
#
#      user = User.from_provider(request.env["omniauth.auth"])
#      if user.persisted?
#        sign_in_and_redirect user, notice: "Signed in successfully"
#      else
#        redirect_to new_user_registration_url
#      end
#    end
#    alias_method :twitter, :all



    # rescue_from, ActionController::UnknownAction

    # Ensure callback urls are created for providers
    # defined on the User / omniauth class
    Devise.omniauth_providers.each do |provider|
      class_eval("def #{provider}; create; end")
    end

    protected

    # If the user is logged in, add authentication to their
    # account, otherwise create or find a user account
    def create
      #if current_user
      #  find_or_create_authentication_for_current_user(omniauth)
      #else
        apply_omniauth_to_new_or_existing_user(omniauth)
      #end
    end

    # Apply data from the third party authentication provider into the user's account,
    # including adding or updating the user token
    def find_or_create_authentication_for_current_user(omniauth)
      current_user.apply_omniauth(omniauth)
      current_user.save
      flash[:notice] = "Successfully enabled #{omniauth['provider']} authentication."
      redirect_to edit_user_registration_path
    end

    def apply_omniauth_to_new_or_existing_user(omniauth)
      # Check to see if the omniauth data belongs to a user account
      authentication = Authentication.find_by_provider_and_uid(omniauth.provider, omniauth.uid)
      if authentication # If a user has used this third party authentication method before...
        sign_in_existing_user_with_omniauth(authentication.user, omniauth)
      else # User has never signed in with this third party authentication
        register_new_user_with_omniauth(omniauth)
      end
    end

    def sign_in_existing_user_with_omniauth(user, omniauth)
      user.apply_omniauth(omniauth)
      user.save
      sign_in_and_redirect_user(user, omniauth.provider)
    end

    def register_new_user_with_omniauth(omniauth)
      user = User.omniauth_find_or_initialize(omniauth)
      if user.save # Save user if valid
        sign_in_and_redirect_user(user, omniauth.provider)
      else # Prompt for additional information if user is invalid
        #binding.pry
        #session["devise.user_attributes"] = user.attributes
        session["devise.omniauth_hash"] = omniauth_for_session
        #binding.pry
        redirect_to new_user_registration_url, :alert => "Please complete your registration."
      end
    end

    def sign_in_and_redirect_user(user, provider)
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.humanize.titleize
      sign_in_and_redirect(:user, user, :event => :authentication )
    end

    # redirect_to request.env['omniauth.origin'] || '/default'

    # Return the environment's omniauth data
    def auth_hash
      request.env["omniauth.auth"]
    end

    # Return the environment's omniauth data in a Hashie::Mash
    def omniauth
      Hashie::Mash.new auth_hash
    end

    def omniauth_for_session
      omniauth.
        slice("provider", "uid", "info", "credentials").
        #merge({ "extra" => { "raw_info" => omniauth.extra.raw_info } }).
        to_hash
    end

    def failure_message
      exception = env["omniauth.error"]
      error   = exception.error_reason if exception.respond_to?(:error_reason)
      error ||= exception.error        if exception.respond_to?(:error)
      error ||= custom_failure_messages
      error.to_s.humanize.downcase if error
    end

    def custom_failure_messages
      case env["omniauth.error.type"]
      when :invalid_credentials
        "of invalid credentials"
      when :invalid_response
        "of invalid response"
      when :timeout
        "the service failed to respond"
      else
        env["omniauth.error.type"].to_s
      end
    end

  end
end

