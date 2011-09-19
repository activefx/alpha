class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :created_by_omniauth, :type => Boolean, :default => false

  attr_accessible :email, :password, :password_confirmation, :remember_me

  #has_many :user_tokens, :autosave => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable
  devise :database_authenticatable, :registerable,  :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable

  include Extensions::ForDevise




  #protected

















end

