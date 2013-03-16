class Administrator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Extensions::DatabaseAuthenticatable
  #include Extensions::Confirmable
  include Extensions::Lockable
  #include Extensions::Recoverable
  #include Extensions::Registerable
  #include Extensions::Rememberable
  include Extensions::Timeoutable
  #include Extensions::TokenAuthenticable
  include Extensions::Trackable
  include Extensions::Validatable
  include Extensions::DeviseHelpers
  if BACKGROUND_WORKERS_AVAILABLE
    include Extensions::Async
  end
end
