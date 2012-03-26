class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Database authenticatable
  field :email,                   :type => String, :null => false
  field :encrypted_password,      :type => String, :null => false

  ## Recoverable
  field :reset_password_token,    :type => String
  field :reset_password_sent_at,  :type => Time

  ## Rememberable
  field :remember_created_at,     :type => Time

  ## Trackable
  field :sign_in_count,           :type => Integer
  field :current_sign_in_at,      :type => Time
  field :last_sign_in_at,         :type => Time
  field :current_sign_in_ip,      :type => String
  field :last_sign_in_ip,         :type => String

  ## Encryptable
  # field :password_salt,           :type => String

  ## Confirmable
  field :confirmation_token,      :type => String
  field :confirmed_at,            :type => Time
  field :confirmation_sent_at,    :type => Time
  field :unconfirmed_email,       :type => String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts,         :type => Integer # Only if lock strategy is :failed_attempts
  field :unlock_token,            :type => String # Only if unlock strategy is :email or :both
  field :locked_at,               :type => Time

  ## Token authenticatable
  # field :authentication_token,    :type => String

  ## Omniauthable
  field :created_by_omniauth,     :type => Boolean, :default => false

  field :invite_code,             :type => String

  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :invite_code

  has_many :authentications, :dependent => :destroy,
                             :autosave => true,
                             :validate => false

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable
  devise :database_authenticatable, :registerable,  :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable

  # Devise extensions must be included after devise
  # modules have been defined for the class
  include Extensions::ForDevise
  include Extensions::ForOmniauth

  validates :invite_code, :presence => true, :if => :beta_user_signup?

  validate :invitation_token_validity

  protected

  def beta_user_signup?
    site_in_beta? && !persisted?
  end

  def site_in_beta?
    configatron.in_beta == true
  end

  def invitation_token_validity
    if beta_user_signup?
      token = InviteCode.where(token: invite_code).first
      unless token && token.invitation_accepted_at.nil?
        errors[:invite_code] << "was not valid"
      end
      if token && token.invitation_sent_to == email
        skip_confirmation!
      end
    end
  end

  def self.search(search, page)
    if search
      where(:email => /#{Regexp.quote(search)}/).page(page || 1).per(10)
    else
      page(page || 1).per(10)
    end
  end


#  def apply_omniauth(omniauth)
#    #add some info about the user
#    #self.name = omniauth['user_info']['name'] if name.blank?
#    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
#    self.email = omniauth['user_info']['email'] if self.email.blank?
#    unless omniauth['credentials'].blank?
#      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
#      #user_tokens.build(:provider => omniauth['provider'],
#      #                  :uid => omniauth['uid'],
#      #                  :token => omniauth['credentials']['token'],
#      #                  :secret => omniauth['credentials']['secret'])
#    else
#      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
#    end
#    #self.confirm!# unless user.email.blank?
#  end

#  def apply_omniauth(omniauth)
#    self.login = omniauth['user_info']['name'] if login.blank?
#    self.login = omniauth['user_info']['nickname'] if login.blank?
#    user_tokens.build(:provider => omniauth['provider'],
#                      :token => omniauth['credentials']['token'],
#                      :secret => omniauth['credentials']['secret'],
#                      :uid => omniauth['uid'])
#  end

#  def apply_omniauth(omniauth)
#    #add some info about the user

#    fbinfo = ::Hashie::Mash.new((omniauth["user_info"] rescue {}))

#    access_token = omniauth["credentials"]["token"] rescue nil

#    #raise "Can't authorize!" unless valid_facebook_auth? fbinfo

#    #self.facebok_id = fbinfo.id
#    self.email ||= fbinfo.email
#    self.first_name ||= fbinfo.first_name
#    self.last_name ||= fbinfo.last_name
#    #self.password ||= Devise.friendly_token[0,40]
#    #self.birthday = Date.parse(fbinfo.birthday) rescue nil
#    if changed? && !email.blank? && self.save(:validate => false)
#      Rails.logger.warn "Persisting user failed: #{self.to_s} with errors:\n#{self.errors.full_messages.join("\n")}\n\n"
#    end

#    #self.name = omniauth['user_info']['name'] if name.blank?
#    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
#    save(:validate => false)
#    t = UserToken.find_or_initialize_by(:provider => omniauth['provider'], :uid => omniauth['uid'])
#    t.apply_omniauth(omniauth)
#    t
#  end

#  def apply_omniauth(omniauth)
#    return if omniauth['provider'].blank? || omniauth['uid'].blank?
#    #add some info about the user
#    self.apply_user_info(omniauth, omniauth['provider'])
#    # Build the user token
#    omniauth_params = self.build_omniauth_params(omniauth)
#    if token = self.user_tokens.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
#      token.update_attributes(omniauth_params)
#    else
#      if self.new_record?
#        self.user_tokens.build(omniauth_params)
#      else
#        self.user_tokens.create(omniauth_params)
#      end
#    end
#  end



end
#  has_many :user_tokens, autosave: true

#  class << self

#    # Configure authentication_keys here instead of devise.rb initialzer so we don't overwrite standard devise models
#    def authentication_keys
#      [:login]
#    end

#    # Find user by email or username.
#    # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
#    def find_for_database_authentication(conditions)
#      login = conditions.delete(:login)
#      self.any_of({ :username => login }, { :email => login }).first
#    end

#    def find_by_email(email)
#      where(:email => email).first
#    end

#    def find_by_reset_password_token(reset_password_token)
#      where(:reset_password_token => reset_password_token).first
#    end


##    def new_with_session(params, session)
##      super.tap do |user|
##        if data = session[:omniauth]
##          omniauth_params = {:provider => data['provider'], :uid => data['uid']}
##          if credentials = data['credentials']
##            omniauth_params.merge!(:token => credentials['token']) unless credentials['token'].blank?
##            omniauth_params.merge!(:secret => credentials['secret']) unless credentials['secret'].blank?
##          end
##          token = self.user_tokens.build( omniauth_params )
##          token.save #(:validate => false) if (t[:id].blank? rescue true)
##          token
##        end
##      end
##    end

#    def new_with_session(params, session)
#      super.tap do |user|
#        if omniauth = session[:omniauth]
#          user.apply_omniauth(omniauth)
#          user.valid?
#        end
#      end
#    end

#    # Find or initialize a user if no UserToken was found
#    def omniauth_find_or_initialize(omniauth)
#      email = omniauth.recursive_find_by_key("email")
#      if email.blank?
#        user = User.new
#      else
#        user = User.find_or_initialize_by(:email => email)
#      end
#      user.apply_omniauth_initialization if user.new_record?
#      user.apply_omniauth(omniauth)
#      return user
#    end

#  end

#  def third_party_authentications
#    user_tokens.collect{|t| t.provider.to_sym}
#  end

#  def available_third_party_authentications
#    User.omniauth_providers - third_party_authentications
#  end

#  # Alternatively, you could overwrite Devise's password_required? method
#  def apply_omniauth_initialization
#    pass = Devise.friendly_token[0,20]
#    self.password = pass
#    self.password_confirmation = pass
#    self.created_by_omniauth = true
#  end

#  def provider(name)
#    self.user_tokens.find_by_provider(name.to_s)
#  end







#  def password_required?
#    (user_tokens.empty? || !password.blank?) && super
#  end

  # Causes editing user without password to fail
#  def password_required?
#    ((user_tokens.empty? || !password.blank?) rescue nil) || super
#  end

#  def acceptible?
#    (valid? && active?) rescue false
#  end



#  def facebook_client
#    @fb_client ||= FBGraph::Client.new(
#                                       :client_id => Appconf.integrations.facebook.id,
#                                       :secret_id => Appconf.integrations.facebook.secret)
#                                       if t = (provider(:facebook).token rescue nil)
#                                         @fb_client.set_token(t)
#                                       else
#                                         @fb_client
#                                       end
#  end


  # BEGIN https://github.com/holden/devise-omniauth-example
  # https://github.com/holden/devise-omniauth-example/blob/master/app/models/user.rb





  # https://github.com/shingara/base_app_mongoid/blob/master/app/models/user.rb





  # END https://github.com/holden/devise-omniauth-example

  # https://github.com/wink/backbone/blob/master/app/models/person.rb
#  def self.find_for_facebook_registration(fb_data, signed_in_resource=nil)
#    data = fb_data['registration']
#    if person = self.where(:email => data["email"]).first
#      person
#    else # Create a person with a stub password.
#      self.create!(
#        :email => data['email'],
#        :name => data['name'],
#        :facebook_uid => fb_data['user_id'],
#        :facebook_token => fb_data['oauth_token'],
#        :location_name => data['location']['name'],
#        :location_id => data['location']['id'],
#        :birthday => data['birthday'].present? ? Date.parse(data['birthday']) : nil,
#        :gender => data['gender'],
#        :password => Devise.friendly_token[0,20]
#      )
#    end
#  end

# Schema provided under omniauth.auth
# Fields marked required will always be present

#  provider (required) - The provider with which the user authenticated (e.g. 'twitter' or 'facebook')
#  uid (required) - An identifier unique to the given provider, such as a Twitter user ID
#  user_info (required) - A hash containing information about the user
#   name (required) - The best display name known to the strategy. Usually a concatenation of first and last name, but may also be an arbitrary designator or nickname from some systems
#   email - The e-mail of the authenticating user. Should be provided if at all possible (but some sites such as Twitter do not provide this information)
#   nickname - The username of an authenticating user (such as your @-name from Twitter or GitHub account name)
#   first_name
#   last_name
#   location - The general location of the user, usually a city and state.
#   description - A short description of the authenticating user.
#   image - A URL representing a profile image of the authenticating user. Where possible, should be specified to a square, roughly 50x50 pixel image.
#   phone - The telephone number of the authenticating user (no formatting is enforced).
#   urls - A hash containing key value pairs of an identifier for the website and its URL. For instance, an entry could be "Blog" => "http://intridea.com/blog"
#  credentials - If the authenticating service provides some kind of access token or other credentials upon authentication, these are passed through here.
#   token - Supplied by OAuth and OAuth 2.0 providers, the access token.
#   secret - Supplied by OAuth providers, the access token secret.
#  extra - Contains extra information returned from the authentication provider. May be in provider-specific formats.
#   user_hash - A hash of all information gathered about a user in the format it was gathered. For example, for Twitter users this is a hash representing the JSON hash returned from the Twitter API.






# https://github.com/shingara/base_app_mongoid/blob/master/app/models/user.rb
#  class User
#    include Mongoid::Document

#    # Include default devise modules. Others available are:
#    # :token_authenticatable, :confirmable, :lockable and :timeoutable
#    devise :database_authenticatable, :registerable,
#           :recoverable, :rememberable, :trackable,
#           :omniauthable

#    field :login, :type => String

#    validates_presence_of :login
#    validates_uniqueness_of :login, :email, :allow_blank => true
#    validates_format_of :email,
#      :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i,
#      :allow_blank => true
#    validates_presence_of :password, :if => :password_required?
#    validates_confirmation_of :password
#    validates_length_of :password, :minimum => 4, :allow_blank => true

#    attr_accessible :login, :email, :password, :password_confirmation, :remember_me

#    embeds_many :user_tokens

#    validates_uniqueness_of :login
#    validates_presence_of :login

#    ##
#    # Methode use by Devise to find user by conditions.
#    # We accept authentication by email or login
#    #
#    # Method use by Devise
#    #
#    def self.find_for_database_authentication(conditions)
#      self.where({ :login => conditions[:email] }).first ||
#        self.where({ :email => conditions[:email] }).first
#    end

#    ##
#    # Allow to authenticate by ominauth and create user_token
#    #
#    # Method use by Devise
#    #
#    def self.new_with_session(params, session)
#      super.tap do |user|
#        if data = session[:omniauth]
#          user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
#        end
#      end
#    end

#    def apply_omniauth(omniauth)
#      self.login = omniauth['user_info']['name'] if login.blank?
#      self.login = omniauth['user_info']['nickname'] if login.blank?
#      user_tokens.build(:provider => omniauth['provider'],
#                        :token => omniauth['credentials']['token'],
#                        :secret => omniauth['credentials']['secret'],
#                        :uid => omniauth['uid'])
#    end

#    def password_required?
#      new_record? && user_tokens.empty?
#    end

#    def twitter_user_tokens
#      user_tokens.where(:provider => 'twitter').first
#    end

#    def tweets
#      if twitter_user_tokens
#        twitter_user_tokens.tweets
#      else
#        []
#      end
#    end

#  end

#  class UserToken
#    include Mongoid::Document

#    field :provider, :type => String
#    field :uid, :type => String
#    field :token, :type => String
#    field :secret, :type => String

#    embedded_in :user

#    validate :should_be_uniq

#    def should_be_uniq
#      errors.add(:base, 'need to be uniq') if User.where('user_tokens.provider' => self.provider,
#                                                         'user_tokens.uid' => self.uid).first
#    end

#    def tweets
#      Twitter.configure do |config|
#        config.consumer_key = BaseApp::Application.config.twitter['app_id']
#        config.consumer_secret = BaseApp::Application.config.twitter['app_secret']
#        config.oauth_token = self.token
#        config.oauth_token_secret = self.secret
#      end
#      Twitter.user_timeline
#    end

#  end

