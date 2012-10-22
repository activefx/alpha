class Api::V1::RegistrationsController < Api::V1::BaseController

  skip_before_filter :authenticate_api_user!
  skip_before_filter :rate_limit_api_requests!

  def create
    user = User.new(params[:user])
    if user.save
      user.ensure_authentication_token_for_api!
      render :status => 201, :json => { :auth_token => user.authentication_token, :email => user.email }
      return
    else
      warden.custom_failure!
      raise Api::UnprocessableEntity, user.errors.to_hash
    end
  end

end
