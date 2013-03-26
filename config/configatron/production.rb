# Override your default settings for the Production environment here.
#
# Example:
#   configatron.file.storage = :s3

  # OpenID config
  # Must be './tmp' for Heroku
  configatron.open_id.storage_location = './tmp'

  # Set to true to start accepting Stripe payments
  configatron.stripe.enabled = false

  # Facebook omniauth config
  configatron.facebook.app_id = ENV['FACEBOOK_APP_ID']
  configatron.facebook.app_key = ENV['FACEBOOK_APP_KEY']
