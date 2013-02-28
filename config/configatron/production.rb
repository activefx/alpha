# Override your default settings for the Production environment here.
#
# Example:
#   configatron.file.storage = :s3

  # OpenID config
  # Must be './tmp' for Heroku
  configatron.open_id.storage_location = './tmp'

  # Set to true to start accepting Stripe payments
  configatron.stripe.enabled = false

  # Redis
  configatron.redis.url = ENV['OPENREDIS_URL']
