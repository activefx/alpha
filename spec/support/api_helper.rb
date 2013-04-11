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

# Good sample Rack::Test spec from
# http://railsware.com/blog/2013/04/08/api-with-ruby-on-rails-useful-tricks/
#
# require 'spec_helper'
#
# describe "api/v1/objects", api: true do
#   let(:url) { "api/v1/objects" }
#   let(:object) { Factory.create(:object) }
#   let(:token) { "YOUR_SECRET_TOKEN" }
#   let(:data) { JSON.parse(last_response.body) }
#
#   before(:each) { get url, token: token }       # here's where API call made
#
#   subject { data }
#
#   it { should have(1).object }
# end
