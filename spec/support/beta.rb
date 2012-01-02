RSpec.configure do |config|
  config.before(:each, :beta) do
    configatron.in_beta = true
  end
  config.after(:each, :beta) do
    configatron.in_beta = false
  end
end

