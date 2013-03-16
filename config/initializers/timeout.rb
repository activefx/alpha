if Rails.env.production?
  Rack::Timeout.timeout = 10  # seconds
else
  Rack::Timeout.timeout = 30
end
