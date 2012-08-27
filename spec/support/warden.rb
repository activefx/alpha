RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.before(:each) { Warden.test_mode! }
  config.after(:each)  { Warden.test_reset! }
end
