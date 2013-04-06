# Put all your default configatron settings here.
require 'openid/store/filesystem'

# CONTACT INFORMATION
#
# Use these configuration settings to adjust contact information on the site
#
configatron.contact.email = "please-change-me@example.com"
configatron.contact.company_name = "Alpha"
configatron.contact.address_one = "555 Main St"
configatron.contact.address_two = nil
configatron.contact.city = "Beverly Hills"
configatron.contact.state = "CA"
configatron.contact.state_name = "California"
configatron.contact.postal_code = "90210"
configatron.contact.country = "United States"
configatron.contact.phone = "+1 (610) 555-1212"
configatron.contact.start_of_operation = "March 25th, 2012"

# RAILS APPLICATION SETTINGS
#
configatron.secret_token = ENV['SECRET_TOKEN']
configatron.in_beta = false

# DEVISE SETTINGS
#
configatron.devise_mailer_sender = "please-change-me@example.com"

# OMNIAUTH SETTINGS
#
configatron.omniauth.require_password = false
configatron.omniauth.require_email = true
# OpenID config
# Must be './tmp' for Heroku and is set as such in configatron/production.rb
configatron.open_id.storage_location = '/tmp'
configatron.open_id.storage_handler = OpenID::Store::Filesystem.new(configatron.open_id.storage_location)
# Github omniauth config
configatron.github.app_id = ENV['GITHUB_APP_ID']
configatron.github.app_key = ENV['GITHUB_APP_KEY']
# LinkedIn omniauth config
configatron.linkedin.app_id = ENV['LINKED_IN_APP_ID']
configatron.linkedin.app_key = ENV['LINKED_IN_APP_SECRET']
# Facebook omniauth config
configatron.facebook.app_id = ENV['LOCAL_FACEBOOK_APP_ID']
configatron.facebook.app_key = ENV['LOCAL_FACEBOOK_APP_SECRET']
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

# EMAIL SERVICE SETTINGS
#
configatron.mailchimp.api_key = ENV['MAILCHIMP_API_KEY']
configatron.mandrill.username = ENV["MANDRILL_USERNAME"]
configatron.mandrill.api_key = ENV['MANDRILL_APIKEY']

# ERROR HANDLING SETTINGS
#
configatron.exceptional.api_key = ENV['EXCEPTIONAL_API_KEY']

# AMAZON WEB SERVICES SETTINGS
#
configatron.aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
configatron.aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
configatron.aws.asset_bucket = ENV['FOG_DIRECTORY']

# STRIPE SETTINGS
#
# Set configatron.stripe.enabled true in configatron/production.rb to start
# accepting Stripe payments in production
#
configatron.stripe.enabled = false
configatron.stripe.test_api_key = ENV['STRIPE_TEST_SECRET_KEY']
configatron.stripe.test_public_key = ENV['STRIPE_TEST_PUBLIC_KEY']
configatron.stripe.live_api_key = ENV['STRIPE_LIVE_SECRET_KEY']
configatron.stripe.live_public_key = ENV['STRIPE_LIVE_PUBLIC_KEY']

# REDIS SETTINGS
#
configatron.redis.url = ENV['REDISTOGO_URL']

# HEROKU API SETTINGS
#
configatron.heroku.app_name = ENV['HEROKU_APP_NAME']
configatron.heroku.api_key = ENV['HEROKU_API_KEY']

