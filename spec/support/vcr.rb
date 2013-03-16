def sensitive_keys
  key_file = File.open(File.join(Rails.root, ".env"), "r")
  [].tap do |keys|
    key_file.each do |line|
      if line =~ /_key|_id|_secret/i
        keys << /(?<=\=).+/.match(line.strip).to_s
      end
    end
  end
end

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = Rails.root.join("spec", "cassettes")
  c.hook_into :webmock # :typhoeus, :faraday, :fakeweb, or :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
  sensitive_keys.each do |sensitive_value|
    unless sensitive_value.nil?
      c.filter_sensitive_data('SensitiveValue') { sensitive_value }
    end
  end
end

RSpec.configure do |config|
  config.include WebMock::API
  # c.around(:each, :vcr) do |example|
  #   name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
  #   options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
  #   VCR.use_cassette(name, options) { example.call }
  # end
end

