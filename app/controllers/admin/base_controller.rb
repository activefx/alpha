module Admin
  class BaseController < ApplicationController

    before_filter :authenticate_administrator!


  end
end

