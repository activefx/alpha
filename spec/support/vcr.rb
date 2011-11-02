VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = Rails.root.join("spec", "cassettes")
  c.hook_into :webmock # :typhoeus, :faraday, :fakeweb, or :webmock
  c.default_cassette_options = { :record => :new_episodes }
  [
    configatron.github.app_id,
    configatron.github.app_key,
    configatron.linked_in.app_id,
    configatron.linked_in.app_secret,
    configatron.facebook.app_id,
    configatron.facebook.app_key,
    configatron.twitter.app_id,
    configatron.twitter.app_secret,
  ].each do |sensitive_value|
    unless sensitive_value.nil?
      c.filter_sensitive_data('SensitiveValue') { sensitive_value }
    end
  end
end

RSpec.configure do |config|
  config.include WebMock::API
  config.extend VCR::RSpec::Macros
  # c.around(:each, :vcr) do |example|
  #   name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
  #   options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
  #   VCR.use_cassette(name, options) { example.call }
  # end
end

