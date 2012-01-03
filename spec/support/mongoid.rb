# Mongoid must be restricted to models
# to avoid conflict with Capybara matchers
# see https://github.com/jnicklas/capybara/issues/506
RSpec.configure do |config|
  config.include Mongoid::Matchers, :type => :model
end

