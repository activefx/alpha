# Put all your default configatron settings here.
require 'openid/store/filesystem'

# Example:
#   configatron.emails.welcome.subject = 'Welcome!'
#   configatron.emails.sales_reciept.subject = 'Thanks for your order'
#
#   configatron.file.storage = :s3

  configatron.in_beta = false
  configatron.background_workers_available = HEROKU_WORKERS > 0
  configatron.devise_mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
  configatron.omniauth.require_password = false
  configatron.omniauth.require_email = true

  # AWS / Fog config
  configatron.aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
  configatron.aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  configatron.aws.asset_bucket = ENV['FOG_DIRECTORY']

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

  configatron.mailchimp.api_key = ENV['MAILCHIMP_API_KEY']
  configatron.mandrill.username = ENV["MANDRILL_USERNAME"]
  configatron.mandrill.api_key = ENV['MANDRILL_API_KEY']

  configatron.exceptional.api_key = ENV['EXCEPTIONAL_API_KEY']

  # Set to true in configatron/production.rb to start accepting
  # Stripe payments in production
  configatron.stripe.enabled = false
  configatron.stripe.test_api_key = ENV['STRIPE_TEST_SECRET_KEY']
  configatron.stripe.test_public_key = ENV['STRIPE_TEST_PUBLIC_KEY']
  configatron.stripe.live_api_key = ENV['STRIPE_LIVE_SECRET_KEY']
  configatron.stripe.live_public_key = ENV['STRIPE_LIVE_PUBLIC_KEY']

  # Redis
  configatron.redis.url = ENV['OPENREDIS_DEV_URL']

  configatron.openredis.api_username = ENV['OPENREDIS_API_USERNAME']
  configatron.openredis.api_key = ENV['OPENREDIS_API_KEY']

  configatron.heroku.app_name = ENV['HEROKU_APP_NAME']
  configatron.heroku.api_key = ENV['HEROKU_API_KEY']

