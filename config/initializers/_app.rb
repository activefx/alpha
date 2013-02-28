# this file loads first so other initializers have access

# Determines the number of workers
# Used for initializers and models that depend on at least
# one background worker running
HEROKU = Heroku::API.new api_key: ENV['HEROKU_API_KEY']
HEROKU_WORKERS = HEROKU.get_app(ENV['HEROKU_APP_NAME']).try(:body).try(:[], 'workers').to_i

require 'configatron'
Configatron::Rails.init

require File.join(Rails.root, "lib", "core_ext.rb")
require File.join(Rails.root, "lib", "simple_form", "label_nested_input.rb")
