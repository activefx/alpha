if BACKGROUND_WORKERS_AVAILABLE
  require 'devise-async'
  Devise::Async.backend = :sidekiq
end
