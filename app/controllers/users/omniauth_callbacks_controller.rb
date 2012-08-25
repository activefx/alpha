module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    skip_before_filter :show_beta_page?

    # Ensure callback urls are created for providers
    # defined on the User / omniauth class
    Devise.omniauth_providers.each do |provider|
      class_eval %Q{
        def #{provider}
          create
        end
      }
    end

    protected

    # If the user is logged in, add authentication to their
    # account, otherwise create or find a user account
    def create
      if current_user
        find_or_create_authentication_for_current_user
      else
        apply_omniauth_to_new_or_existing_user
      end
    end

    def apply_omniauth_to_new_or_existing_user
      auth = Authentication.where(omniauth.slice(:provider, :uid)).first
      if user = auth.try(:user)
        auth.apply_omniauth(omniauth)
        sign_in_and_redirect_user(user)
      else
        apply_omniauth_to_new_user
      end
    end

    def sign_in_and_redirect_user(user)
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", :kind => provider_name)
      sign_in_and_redirect(:user, user, :event => :authentication )
    end

    def apply_omniauth_to_new_user
      user = User.new_from_omniauth(omniauth)
      if user.persisted?
        sign_in_and_redirect_user(user)
      else
        session["devise.omniauth_hash"] = omniauth_for_session
        flash[:alert] = I18n.t 'devise.registrations.finish'
        redirect_to new_user_registration_url
      end
    end

    # Apply data from the third party authentication provider into the user's account,
    # including adding or updating the user token
    #
    # TODO: update to use redirect_to request.env['omniauth.origin'] || '/default'
    def find_or_create_authentication_for_current_user
      current_user.add_authentication(omniauth)
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.added', :kind => provider_name
      redirect_to edit_user_registration_path
    end

    def sign_in_existing_user_with_omniauth(user, omniauth)
      user.apply_omniauth(omniauth)
      user.save
      sign_in_and_redirect_user(user, omniauth.provider)
    end

    def register_new_user_with_omniauth(omniauth)
      user = User.from_omniauth(omniauth)
      if user.save # Save user if valid
        sign_in_and_redirect_user(user, omniauth.provider)
      else # Prompt for additional information if user is invalid
        session["devise.omniauth_hash"] = omniauth_for_session
        redirect_to new_user_registration_url, :alert => "Please complete your registration."
      end
    end

    # Return the environment's omniauth data
    def auth_hash
      # raise request.env['omniauth.auth'].to_yaml
      request.env["omniauth.auth"]
    end

    # Return the environment's omniauth data in a Hashie::Mash
    def omniauth
      Hashie::Mash.new auth_hash
    end

    def provider_name
      omniauth.provider.humanize.titleize
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
