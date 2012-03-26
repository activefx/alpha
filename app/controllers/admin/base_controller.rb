module Admin
  class BaseController < ApplicationController

    layout 'administration'

    before_filter :authenticate_administrator!

  end
end

