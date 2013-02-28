def use_mandrill?
  Rails.env.production? &&
  !configatron.mandrill.username.nil? &&
  !configatron.mandrill.api_key.nil?
end

if use_mandrill?

  ActionMailer::Base.smtp_settings = {
    :address    => "smtp.mandrillapp.com",
    :port       => 587,
    :user_name  => configatron.mandrill.username,
    :password   => configatron.mandrill.api_key
  }
  ActionMailer::Base.delivery_method = :smtp

end
