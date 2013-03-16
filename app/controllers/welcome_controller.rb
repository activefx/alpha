class WelcomeController < ApplicationController

  before_filter :resolve_layout

  def index

  end

  def coming_soon

  end

  protected

  def resolve_layout
    case action_name
    when "coming_soon"
      "landing_page"
    else
      "application"
    end
  end

end

