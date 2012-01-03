module ApplicationHelper

  # Supported flash messages include
  # warning/alert, error, success & info/notice
  def flash_messages
    return if flash.empty?
    flash.collect do |type, message|
      content_tag(:div, :class => "alert-message #{flash_type(type)}", "data-alert" => "alert") do
        link_to("&times;".html_safe, "#", :class => 'close') +
        content_tag(:p, message)
      end
    end.join("\n").html_safe
  end

  # Use to convert flash notices to acceptible
  # Twitter bootstrap css classes
  def flash_type(type)
    case type.to_s
    when "notice" then "info"
    when "alert" then "warning"
    else type.to_s
    end
  end

  def login_status
    case
    when user_signed_in?
      render "layouts/partials/user"
    # when admininistrator_signed_in?
    #   render :partial => "layouts/partials/admin"
    else
      render "layouts/partials/visitor"
    end
  end

  def site_in_beta?
    configatron.in_beta == true
  end

end

