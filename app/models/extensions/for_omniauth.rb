module Extensions
  module ForOmniauth
    extend ActiveSupport::Concern

    included do

    end

    module ClassMethods

      def new_with_session(params, session)
        super.tap do |user|
          if auth_hash = session["devise.omniauth_data"]
            user.apply_omniauth(auth_hash)
          end
        end
      end

      # When enabled, allows a user to set a password during the initial
      # registration process, otherwise they mush always use omniauth
      # to sign in
      def password_authentication_enabled_with_omniauth?
        configatron.omniauth.enable_password_authentication == true
      end

      # Find or initialize a user if no UserToken was found
      def omniauth_find_or_initialize(omniauth)
        email = omniauth.recursive_find_by_key("email")
        if email.blank?
          user = User.new
        else
          user = User.find_or_initialize_by(:email => email)
        end
        if user.new_record?
          user.set_omniauth_flag
          user.apply_omniauth_initialization unless password_authentication_enabled_with_omniauth?
        end
        user.apply_omniauth(omniauth)
        return user
      end

    end

    # Instance Methods

    def apply_omniauth(omniauth)
      omniauth = omniauth.is_a?(Hashie::Mash) ? omniauth : Hashie::Mash.new(omniauth)
      return false if omniauth.provider.blank? || omniauth.uid.blank?
      #add some info about the user
      self.apply_user_info(omniauth, omniauth.provider)
      # Build the user token
      omniauth_params = self.build_omniauth_params(omniauth)
      if authentication = self.authentications.where(:provider => omniauth.provider, :uid => omniauth.uid).first
        authentication.update_attributes(omniauth_params)
      else
        if self.new_record?
          self.authentications.build(omniauth_params)
        else
          self.authentications.create(omniauth_params)
        end

      end
    end

    # Custom logic for adding user information from third party authentications
    def apply_user_info(omniauth, provider = nil)
      if omniauth_email = omniauth.recursive_find_by_key(:email)
        if self.email.blank?
          self.email = omniauth_email
        end
      end
      self.skip_confirmation! if self.email == omniauth_email
    end

    # Sets a user password to avoid triggering the password validations
    # Alternatively, you could overwrite Devise's password_required? method
    def apply_omniauth_initialization
      pass = Devise.friendly_token[0,20]
      self.password = pass
      self.password_confirmation = pass
    end

    def build_omniauth_params(omniauth)
      omniauth_params = {:provider => omniauth.provider.to_s, :uid => omniauth.uid.to_s}
      unless omniauth.credentials.blank?
        credentials = omniauth.credentials
        omniauth_params.merge!(:token => credentials.token) unless credentials.token.blank?
        omniauth_params.merge!(:secret => credentials.secret) unless credentials.secret.blank?
        omniauth_params.merge!(:expires_at => credentials.expires_at) unless credentials.expires_at.blank?
        omniauth_params.merge!(:expires => credentials.expires) unless credentials.expires.blank?
        omniauth_params.merge!(:refresh_token => credentials.refresh_token) unless credentials.refresh_token.blank?
      end
      # Store all of the data for debugging and development
      extra = omniauth.extra.try(:except, 'access_token').try(:to_hash)
      omniauth_params.merge!(:omniauth => extra) unless extra.blank?
      return omniauth_params
    end

    def set_omniauth_flag
      self.created_by_omniauth = true
    end

  end
end



#class OauthProvider::Provider
#  class << self
#    def provider_class(provider_type)
#      return "OauthProvider::Provider::#{provider_type.classify}".constantize
#    end

#    def normalize_oauth(oauth)
#      {
#        provider_type: oauth['provider'],
#        uid: oauth['uid'],
#        username: oauth['extra'].try(:[], 'user_hash').try(:[], 'screen_name'),
#        gender: oauth['extra'].try(:[], 'user_hash').try(:[], 'gender'),
#        nickname: oauth['user_info']['nickname'],
#        email: oauth['user_info']['email'],
#        name: oauth['user_info']['name'],
#        first_name: oauth['user_info']['first_name'],
#        last_name: oauth['user_info']['last_name'],
#        image_url: oauth['user_info']['image'],
#        location_name: oauth['user_info']['location'],
#        token: oauth['credentials']['token'],
#        secret: oauth['credentials']['secret'],
#        expires: nil,
#        verified: oauth['extra'].try(:[], 'user_hash').try(:[], 'verified'),
#        profile_url: oauth['user_info'].try(:[], 'urls').try(:[], oauth['provider'].camelize),
#        bio: oauth['user_info'].try(:[], 'description')
#      }
#    end
#  end
#end



#class OauthProvider::Provider::Facebook < OauthProvider::Provider
#  def self.normalize_oauth(oauth)
#    super(oauth).merge({
#      username: oauth['extra']['user_hash'].try(:[], 'username'),
#      email: oauth['extra']['user_hash']['email'],
#      location_name: oauth['extra']['user_hash']['location'].try(:[], 'name'),
#      bio: oauth['extra']['user_hash'].try(:[], 'bio')
#    })
#  end
#end

