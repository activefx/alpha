class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :show_beta_page?

  # rescue_from, ActionController::UnknownAction,
  #              ActionView::MissingTemplate,
  #              :with => :error_404

  def nobody_signed_in?
    !user_signed_in? && !administrator_signed_in?
  end

  def anybody_signed_in?
    user_signed_in? || administrator_signed_in?
  end

  def landing_page?
    %w(beta_signups).include?(controller_name)
  end

  def home_page?
    root_path == request.path
  end

  def local_request?
    Rails.env.development? or request.remote_ip =~ /(::1)|(127.0.0.1)|((192.168).*)/
  end

  def site_in_beta?
    configatron.in_beta == true
  end

  def administrative_request?
    /administrator_/.match(controller_name) || /admin\//.match(controller_path)
  end

  def user_registration_page?
    controller_path == "devise/registrations"
  end

  def user_sign_in_page?
    controller_path == "devise/sessions"
  end

  def not_an_allowed_page?
    !administrative_request? &&
    !landing_page? &&
    !user_registration_page? &&
    !user_sign_in_page?
  end

  protected

  # Add exceptions for log in page and logged in user
  def show_beta_page?
    if site_in_beta? && nobody_signed_in? && not_an_allowed_page?
      redirect_to beta_signups_path
    end
  end

end

