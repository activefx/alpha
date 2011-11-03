# Put all your default configatron settings here.
require 'openid/store/filesystem'

# Example:
#   configatron.emails.welcome.subject = 'Welcome!'
#   configatron.emails.sales_reciept.subject = 'Thanks for your order'
#
#   configatron.file.storage = :s3

  # OpenID config
  # Must be './tmp' for Heroku
  configatron.open_id.storage_location = '/tmp'
  configatron.open_id.storage_handler = OpenID::Store::Filesystem.new(configatron.open_id.storage_location)
  # Github omniauth config
  configatron.omniauth.github.app_id = nil
  configatron.omniauth.github.app_key = nil
  configatron.omniauth.github.app_scope = 'user,public_repo'
  # LinkedIn omniauth config
  configatron.omniauth.linked_in.app_id = nil
  configatron.omniauth.linked_in.app_secret = nil
  # Facebook omniauth config
  configatron.omniauth.facebook.app_id = nil
  configatron.omniauth.facebook.app_key = nil
  configatron.omniauth.facebook.app_scope = 'email,user_about_me,offline_access'
  # Twitter omniauth config
  configatron.omniauth.twitter.app_id = nil
  configatron.omniauth.twitter.app_secret = nil
  # Google omniauth / openid config
  configatron.omniauth.google.open_id.enabled = false
  configatron.omniauth.google.open_id.name = 'google'
  configatron.omniauth.google.open_id.identifier = 'https://www.google.com/accounts/o8/id'
  # Yahoo omniauth / openid config
  configatron.omniauth.yahoo.open_id.enabled = false
  configatron.omniauth.yahoo.open_id.name = 'yahoo'
  configatron.omniauth.yahoo.open_id.identifier = 'https://me.yahoo.com'

