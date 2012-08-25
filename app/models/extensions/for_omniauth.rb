module Extensions
  module ForOmniauth
    extend ActiveSupport::Concern

    included do

      after_save :auto_confirm!, :unless => :email_required?

    end

    module ClassMethods

      def previously_saved_auth(omniauth)
        Authentication.previously_saved_auth(omniauth)
      end

      def update_or_create_auth(omniauth)
        Authentication.update_or_create_auth(omniauth)
      end

      # If validation fails and additional registration information is
      # required, new_with_session will initialization the user object
      # for registration with available third party information
      def new_with_session(params, session)
        super.tap do |user|
          if auth_hash = session["devise.omniauth_hash"]
            omniauth = Hashie::Mash.new(auth_hash)
            user.set_omniauth_attributes(omniauth)
            user.authentications << previously_saved_auth(omniauth)
            user.set_omniauth_flag(omniauth.provider)
            user.valid?
          end
        end
      end

      # Initialize and try to save a new user from omniauth data
      def new_from_omniauth(omniauth)
        auth = update_or_create_auth(omniauth)
        new.tap do |u|
          u.set_omniauth_attributes(omniauth)
          u.set_omniauth_flag(omniauth.provider)
          if u.save
            u.authentications << auth
          end
        end
      end

      # When enabled, allows a user to set a password during the initial
      # registration process, otherwise they mush always use omniauth
      # to sign in
      def password_required_with_omniauth?
        configatron.omniauth.require_password == true
      end

      # When enabled, allows a user to set an email during the initial
      # registration process, otherwise they mush always use omniauth
      # to sign in
      def email_required_with_omniauth?
        configatron.omniauth.require_email == true
      end

    end

    # Instance Methods

    def password_required?
      super && (no_provider? || self.class.password_required_with_omniauth?)
    end

    def email_required?
      super && (no_provider? || self.class.email_required_with_omniauth?)
    end

    # Used to apply omniauth to existing, signed in users
    def add_authentication(omniauth)
      authentications << new_authentication_from_omniauth(omniauth)
    end

    def new_authentication_from_omniauth(omniauth)
      Authentication.new_from_omniauth(omniauth)
    end

    # Use the provider classes to normalize third party data that you
    # want saved to your user model
    def set_omniauth_attributes(omniauth)
      klass = begin
        "Provider::#{omniauth.provider.titleize}".constantize
      rescue NameError
        Provider::Base
      end
      omniauth_attrs = klass.attributes(omniauth)
      self.attributes.merge!(omniauth_attrs)
    end

    def no_provider?
      created_by_provider.blank?
    end

    def set_omniauth_flag(provider)
      self.created_by_provider = provider
    end

    protected

    def auto_confirm!
      return unless respond_to?(:devise_modules)
      confirm! if devise_modules.include?(:confirmable)
    end

  end
end
