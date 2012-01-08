class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider,        :type => String
  field :uid,             :type => String
  field :token,           :type => String
  field :secret,          :type => String
  field :expires_at,      :type => Integer
  field :expires,         :type => Boolean
  field :refresh_token,   :type => String
  field :omniauth,        :type => Hash

  belongs_to :user

  index( [ [:provider, Mongo::ASCENDING],
           [:uid, Mongo::ASCENDING] ] )

  validates_presence_of   :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_by_provider_and_uid(provider, uid)
    where(:provider => provider, :uid => uid).first
  end

  def self.find_by_provider(provider)
    desc(:updated_at).where(:provider => provider).first
  end

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end

  #  # exclude omniauth from being fetched by default
  #  default_scope without(:omniauth)


end

