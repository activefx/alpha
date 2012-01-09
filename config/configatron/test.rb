# Override your default settings for the Test environment here.
#
# Example:
#   configatron.file.storage = :local

  # OpenID config
  configatron.open_id.storage_location = '/tmp'
  configatron.open_id.storage_handler = OpenID::Store::Filesystem.new(configatron.open_id.storage_location)
  # Github omniauth config
  configatron.github.app_id = 'XXXX'
  configatron.github.app_key = 'XXXX'
  configatron.github.app_scope = 'user,public_repo'
  # LinkedIn omniauth config
  configatron.linkedin.app_id = 'XXXX'
  configatron.linkedin.app_secret = 'XXXX'
  # Facebook omniauth config
  configatron.facebook.app_id = 'XXXX'
  configatron.facebook.app_key = 'XXXX'
  configatron.facebook.app_scope = 'email,user_about_me,offline_access'
  # Twitter omniauth config
  configatron.twitter.app_id = 'XXXX'
  configatron.twitter.app_secret = 'XXXX'
  # Google omniauth / openid config
  configatron.google.open_id.enabled = true
  configatron.google.open_id.name = 'google'
  configatron.google.open_id.identifier = 'https://www.google.com/accounts/o8/id'
  # Yahoo omniauth / openid config
  configatron.yahoo.open_id.enabled = true
  configatron.yahoo.open_id.name = 'yahoo'
  configatron.yahoo.open_id.identifier = 'yahoo.com'

