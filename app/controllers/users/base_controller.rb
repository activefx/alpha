module Users
  class BaseController < ApplicationController

    layout 'dashboard'

    before_filter :authenticate_user!

  end
end
