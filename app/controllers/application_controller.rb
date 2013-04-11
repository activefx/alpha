class ApplicationController < ActionController::Base
  protect_from_forgery

  # The following methods are going to be called, unles they are provided in a skip_before_filter block.
  #   :set_csp_header
  #   :set_hsts_header
  #   :set_x_frame_options_header
  #   :set_x_xss_protection_header
  #   :set_x_content_type_options_header
  #
  ensure_security_headers

  respond_to :html

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

  def not_an_allowed_page?
    !administrative_request? && !landing_page?
  end

  protected

  # Add exceptions for log in page and logged in user
  def show_beta_page?
    if site_in_beta? && nobody_signed_in? && not_an_allowed_page?
      redirect_to comming_soon_path
    end
  end

end

