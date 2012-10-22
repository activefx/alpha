class Api::V1::SessionsController < Api::V1::BaseController

  skip_before_filter :authenticate_api_user!, :only => [ :create ]

  before_filter :ensure_params_exist

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      # sign_in(:user, resource)
      resource.ensure_authentication_token_for_api!
      render :json => {
        :success => true,
        :auth_token => resource.authentication_token,
        :email => resource.email
      }
      return
    end
    invalid_login_attempt
  end

  def destroy
    if current_api_user.expire_authentication_token!
      render :status => 204, :json => { :success => true }
    else
      raise Api::BadRequest, 'You were not successfully signed out.'
    end
  end

  protected

  def ensure_params_exist
    return unless params[:user].try(:[], :email).blank?
    raise Api::BadRequest, 'You are missing the user[email] parameter.'
  end

  def invalid_login_attempt
    warden.custom_failure!
    raise Api::Unauthorized, 'Invalid email or password.'
  end

end

