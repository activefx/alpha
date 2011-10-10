module ApplicationHelper

  # warning, error, success, info
  def flash_messages
    return if flash.empty?

    flash.collect do |type, message|
      content_tag(:div, :class => "alert-message #{type}") do
        link_to("x", "#", :class => 'close') +
        content_tag(:p, message)
      end
    end.join("\n").html_safe

  end

end

