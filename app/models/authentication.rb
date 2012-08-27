class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider,            type: String
  field :uid,                 type: String
  field :token,               type: String
  field :secret,              type: String
  field :expires_at,          type: Integer
  field :expires,             type: Boolean
  field :refresh_token,       type: String
  field :info,                type: Hash
  field :raw_info,            type: Hash

  belongs_to :user

  index({ provider: 1, uid: 1 })

  validates_presence_of   :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_by_provider_and_uid(provider, uid)
    where(provider: provider, uid: uid).first
  end

  def self.find_by_provider(provider)
    desc(:updated_at).where(provider: provider).first
  end

  def self.previously_saved_auth(omniauth)
    where(
      provider:   omniauth.provider,
      uid:        omniauth.uid,
      token:      omniauth.credentials.token,
      secret:     omniauth.credentials.secret
    ).first
  end

  def self.update_or_create_auth(omniauth)
    find_or_initialize_by(omniauth.slice(:provider, :uid)).tap do |a|
      a.apply_omniauth(omniauth)
      a.save
    end
  end

  def self.new_from_omniauth(omniauth)
    new.tap do |a|
      a.apply_omniauth(omniauth)
    end
  end

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end

  def apply_omniauth(omniauth)
    credentials         = omniauth.try(:credentials)
    self.provider       = omniauth.try(:provider)
    self.uid            = omniauth.try(:uid)
    self.token          = credentials.try(:token)
    self.secret         = credentials.try(:secret)
    self.expires_at     = credentials.try(:expires_at)
    self.expires        = credentials.try(:expires)
    self.refresh_token  = credentials.try(:refresh_token)
    self.info           = omniauth.try(:info).try(:to_hash)
    self.raw_info       = omniauth.try(:extra).try(:raw_info).try(:to_hash)
  end

end
