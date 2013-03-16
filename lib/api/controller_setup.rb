module Api
  module ControllerSetup
    extend ActiveSupport::Concern

    included do

      # Prevent asset directory path errors
      include AbstractController::AssetPaths

      # Add support for helpers
      include ActionController::Helpers

      # Support for redirect_to
      include ActionController::Redirecting

      # Basic support for rendering
      include ActionController::Rendering

      # Support for controller filters
      include AbstractController::Callbacks

      # Support for caching
      include ActionController::Caching

      # Add support for render :json and :xml
      include ActionController::Renderers::All

      # Support for stale?
      include ActionController::ConditionalGet

      # Support for the request and response methods
      include ActionController::RackDelegation

      # Support for submiting POST requests without specifying root elements
      include ActionController::ParamsWrapper

      # Support for content negotiation (respond_to, respond_with)
      include ActionController::MimeResponds

      # Protect from CSRF attacks
      include ActionController::RequestForgeryProtection

      # Support for force_ssl
      include ActionController::ForceSSL

      # Support for send_file and send_data
      # include ActionController::DataStreaming

      # Authentication helpers
      include Devise::Controllers::Helpers

      # Authorization helpers
      include CanCan::ControllerAdditions

      # Support for the instrumentation hooks defined by ActionController
      include ActionController::Instrumentation

      # Support for rescue_from
      include ActionController::Rescue

      # Make API controllers aware of application routes
      include Rails.application.routes.url_helpers

      append_view_path "#{Rails.root}/app/views"

      wrap_parameters format: [ :json ]

      ActiveSupport.run_load_hooks(:action_controller, self)

    end

  end
end
