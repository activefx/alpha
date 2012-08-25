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

  # Devise extensions must be included after devise
  # modules have been defined for the class
  include Extensions::ForDevise

end
