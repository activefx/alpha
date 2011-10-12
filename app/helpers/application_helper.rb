module ApplicationHelper

  # warning, error, success, info
  def flash_messages
    return if flash.empty?
    flash.collect do |type, message|
      content_tag(:div, :class => "alert-message #{flash_type(type)}") do
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

end

