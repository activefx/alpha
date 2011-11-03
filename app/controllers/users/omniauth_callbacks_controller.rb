module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    # Ensure callback urls are created for providers
    # defined on the User / omniauth class
    User.omniauth_providers.each do |provider|
      class_eval("def #{provider}; create; end")
    end

    protected

      def create
        # Set a constant for the environment's omniauth data
        omniauth = env["omniauth.auth"] # auth_hash
        if current_user # If the user is already logged in...
          find_or_create_user_token_for_current_user(omniauth)
        else # If a user isn't logged in...
          apply_omniauth_to_new_or_existing_user(omniauth)
        end
      end

      def find_or_create_user_token_for_current_user(omniauth)
        # Apply data from the third party authentication provider into the user's account,
        # including adding or updating the user token
        current_user.apply_omniauth(omniauth)
        current_user.save
        flash[:notice] = "Successfully enabled #{omniauth['provider']} authentication."
        redirect_to edit_user_registration_path
      end

      def apply_omniauth_to_new_or_existing_user(omniauth)
        # Check to see if the omniauth data belongs to a user account
        user_token = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
        if user_token # If a user has used this third party authentication method before...
          sign_in_from_user_token(user_token, omniauth)
        else # User has never signed in with this third party authentication
          register_new_user_from_omniauth(omniauth)
        end
      end

      def sign_in_from_user_token(user_token, omniauth)
        user = user_token.user
        user.apply_omniauth(omniauth)
        user.save
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
        sign_in_and_redirect(:user, user)
      end

      def register_new_user_from_omniauth(omniauth)
        user = User.omniauth_find_or_initialize(omniauth)
        if user.save # Save user if valid
          # Automatically confirm user if user confirmed their email with the
          # third party authentication provider
          user.skip_confirmation!
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, user)
        else # Prompt for additional information if user is invalid
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url, :alert => "Please complete your registration."
        end
      end

      # redirect_to request.env['omniauth.origin'] || '/default'

  end
end

