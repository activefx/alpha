class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :show_beta_page?

  # rescue_from, ActionController::UnknownAction,
  #              ActionView::MissingTemplate,
  #              :with => :error_404

  def home_page?
    root_path == request.path
  end

  def local_request?
    Rails.env.development? or request.remote_ip =~ /(::1)|(127.0.0.1)|((192.168).*)/
  end

  def in_beta?
    configatron.in_beta == true
  end

  def administrative_request?
    /administrator_/.match(controller_name) || /admin\//.match(controller_path)
  end

  protected

  # TODO: Add exceptions for log in page and logged in user
  def show_beta_page?
    if in_beta? && !administrative_request? && %w(beta_signups).exclude?(controller_name)
      redirect_to beta_signups_path
    end
  end

end

