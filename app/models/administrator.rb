class Administrator
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Database authenticatable
  field :email,              :type => String, :null => false
  field :encrypted_password, :type => String, :null => false

  ## Recoverable
  # field :reset_password_token,   :type => String
  # field :reset_password_sent_at, :type => Time

  ## Rememberable
  # field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, :type => Integer # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  attr_accessible :email, :password, :password_confirmation

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :registerable, :recoverable,
  # :rememberable, :omniauthable, :confirmable
  devise :database_authenticatable, :trackable,
         :validatable, :lockable, :timeoutable

  # Devise extensions must be included after devise
  # modules have been defined for the class
  include Extensions::ForDevise

end

