RSpec.configure do |config|
  # Beta behavior must be tagged in specific examples,
  # regardless of configatron's defaults or environment
  # specific variables
  config.before(:all) do
    configatron.in_beta = false
  end
  config.before(:each, :beta) do
    configatron.in_beta = true
  end
  config.after(:each, :beta) do
    configatron.in_beta = false
  end
end

