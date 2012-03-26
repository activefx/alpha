module Admin
  class UsersController < Admin::BaseController

    def index
      #@users = User.page(params[:page]).per(10)
      @users = User.search(params[:search], params[:page])
    end

    def show
      @user = User.find(params[:id])
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_url
    end

  end
end

