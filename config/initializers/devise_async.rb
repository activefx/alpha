if Rails.env.production? && configatron.background_workers_available
  require 'devise-async'
  Devise::Async.backend = :sidekiq
end
