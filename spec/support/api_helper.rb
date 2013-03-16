module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def api_helpers
    :available
  end
end

RSpec.configure do |config|
  config.include ApiHelper, :api
end
