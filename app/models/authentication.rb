class Authentication
  include Mongoid::Document
  include Mongoid::Timestamps

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
end

