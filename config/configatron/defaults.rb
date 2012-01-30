# Put all your default configatron settings here.
require 'openid/store/filesystem'

# Example:
#   configatron.emails.welcome.subject = 'Welcome!'
#   configatron.emails.sales_reciept.subject = 'Thanks for your order'
#
#   configatron.file.storage = :s3
  configatron.in_beta = false
  configatron.devise_mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
  configatron.omniauth.enable_password_authentication = false

  # OpenID config
  # Must be './tmp' for Heroku
  configatron.open_id.storage_location = '/tmp'
  configatron.open_id.storage_handler = OpenID::Store::Filesystem.new(configatron.open_id.storage_location)
  # Github omniauth config
  configatron.github.app_id = ENV['GITHUB_APP_ID']
  configatron.github.app_key = ENV['GITHUB_APP_KEY']
  # LinkedIn omniauth config
  configatron.linkedin.app_id = ENV['LINKED_IN_APP_ID']
  configatron.linkedin.app_key = ENV['LINKED_IN_APP_SECRET']
  # Facebook omniauth config
  configatron.facebook.app_id = ENV['FACEBOOK_APP_ID']
  configatron.facebook.app_key = ENV['FACEBOOK_APP_KEY']
  # Twitter omniauth config
  configatron.twitter.app_id = ENV['TWITTER_APP_ID']
  configatron.twitter.app_key = ENV['TWITTER_APP_SECRET']
  # Google omniauth / openid config
  configatron.google.open_id.enabled = false
  configatron.google.open_id.name = 'google'
  configatron.google.open_id.identifier = 'https://www.google.com/accounts/o8/id'
  # Yahoo omniauth / openid config
  configatron.yahoo.open_id.enabled = false
  configatron.yahoo.open_id.name = 'yahoo'
  configatron.yahoo.open_id.identifier = 'https://me.yahoo.com'

