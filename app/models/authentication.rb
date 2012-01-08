class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, :type => String
  field :uid, :type => String
  field :token, :type => String
  field :secret, :type => String
  field :omniauth, :type => Hash

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

#  # provider_type: facebook, linked_in, twitter, etc.
#  field :provider_type, type: String, index: true
#  # uid of profile on provider network; e.g. facebook uid
#  field :uid,           type: String, index: true

#  # oauth tokens
#  field :token,         type: String
#  field :secret,        type: String
#  field :token_expires, type: DateTime

#  # cached data
#  field :oauth_data,    type: String

#  # optional data
#  field :nickname,      type: String
#  field :profile_url,   type: String
#  field :image_url,     type: String

#  belongs_to :user, index: true

#  validates_presence_of :provider_type, :uid, :user

#  # exclude oauth_data from being fetched by default
#  default_scope without(:oauth_data)



#  def self.find_from_hash(hash)
#    find_by_provider_and_uid(hash['provider'], hash['uid'])
#  end

#  def self.create_from_hash(hash, user = nil)
#    user ||= User.create(hash)
#    self.create(hash.merge(:user => user).merge(hash['credentials']))
#    #, :uid => hash['uid'], :provider => hash['provider'])
#  end

#  def apply_omniauth(omniauth)
#    return false if (omniauth['credentials'].blank? rescue true)
#    self.attributes = {
#      :provider => omniauth['provider'],
#      :user_id => self.user_id,
#      :uid => omniauth['uid'],
#      :token => omniauth['credentials']['token'],
#      :secret => omniauth['credentials']['secret']
#    }
#    self.save
#  end


end

