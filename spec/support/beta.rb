RSpec.configure do |config|
  # Beta behavior must be tagged in specific examples,
  # regardless of configatron's defaults or environment
  # specific variables
  config.before(:all) do
    configatron.in_beta = false
  end
  config.around(:each, :beta) do |example|
    configatron.temp do
      configatron.in_beta = true
      example.call
    end
  end
end
