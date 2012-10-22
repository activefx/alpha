class Api::V1::AccountsController < Api::V1::BaseController

  before_filter :authenticate_api_user!

  def show
    @account = current_api_user
    respond_with @account
  end

end
