class ApiKey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :token, :type => String

  validates :token, :presence => true

  embedded_in :user

  attr_accessible nil

  before_validation(:on => :create) do |document|
    document.generate_key
  end

  protected

  def generate_key
   begin
      self.token = SecureRandom.hex
    end while User.where('api_keys.token' => token).exists?
  end

end
