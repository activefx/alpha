class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable
  devise :database_authenticatable, :registerable,  :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable



  # Define instance and class methods to determine if a model
  # is equipped with a specific devise component
  #
  # Must come after including Devise modules but before
  # any use of the methods within the class
  Devise::ALL.each do |method_name|
    # Define class methods
    define_singleton_method(:"#{method_name}?") { devise_modules.include?(method_name) }
    # Define instance methods
    define_method(:"#{method_name}?") { devise_modules.include?(method_name) }
  end

  index :email, :unique => true if database_authenticatable?
  index :confirmation_token, :unique => true if confirmable?
  index :unlock_token, :unique => true if has_unlock_token?


  field :created_by_omniauth, :type => Boolean, :default => false

  attr_accessible :email, :password, :password_confirmation, :remember_me



  #has_many :user_tokens, :autosave => true





  #protected

  def self.has_unlock_token?
    lockable? && unlock_strategy_includes_token?
  end

  def self.unlock_strategy_includes_token?
    [:both, :email].include?(unlock_strategy)
  end

  #private

  def self.deviseable?(method_name)
    devise_modules.include?(method_name)
  end

end

