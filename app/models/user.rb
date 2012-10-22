class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Extensions::DatabaseAuthenticatable
  include Extensions::Confirmable
  include Extensions::Lockable
  include Extensions::Recoverable
  include Extensions::Registerable
  include Extensions::Rememberable
  include Extensions::Timeoutable
  include Extensions::TokenAuthenticatable
  include Extensions::Trackable
  include Extensions::Validatable
  include Extensions::Omniauthable
  include Extensions::DeviseHelpers
  include Extensions::BetaSignups

  field :username,                type: String
  field :monthly_api_rate_limit,  type: Integer
  field :daily_api_rate_limit,    type: Integer
  field :hourly_api_rate_limit,   type: Integer

  attr_accessible :username

  embeds_many :api_keys, :validate => true

  index({ 'api_keys.token' => 1 }, { unique: true })

  def create_api_key
    api_keys.create
  end

  protected

  def self.search(search = nil, page = 1)
    unless search.blank?
      where(:email => /#{Regexp.quote(search)}/).page(page).per(10)
    else
      page(page).per(10)
    end
  end

end
