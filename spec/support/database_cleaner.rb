RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.orm = "mongoid"
    # With the :truncation strategy you can also pass in options, for example:
    # DatabaseCleaner.strategy = :truncation, {:only => %w[widgets dogs some_other_table]}
    # DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

end

