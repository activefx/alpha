class Administrator
  include Mongoid::Document
  include Mongoid::Timestamps

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

