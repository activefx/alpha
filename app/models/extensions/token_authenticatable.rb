module Extensions
  module TokenAuthenticatable
    extend ActiveSupport::Concern

    included do

      # Token authenticatable fields
      field :authentication_token,    :type => String
      field :token_authenticated_at,  :type => Time

      # Options
      #  token_authentication_key:
      #    Defines name of the authentication token params key.
      #    E.g. /users/sign_in?some_key=...
      #
      devise :token_authenticatable

      # If you want to have a new token every time the user saves his account:
      #
      #  before_save :reset_authentication_token

      # If you want to generate token unless one exists:
      #
      # before_save :ensure_authentication_token

      index({ authentication_token: 1 }, { unique: true })

    end

    # Hook called after token authentication.
    # Useful for deleting the token after it is used.
    #
    # def after_token_authentication
    # end

    def ensure_authentication_token_for_api!
      reset_authentication_token
      self.token_authenticated_at = Time.now
      save(:validate => false)
    end

    def expire_authentication_token!
      self.authentication_token = nil
      save(:validate => false)
    end

    def auth_token_expired?
      !timeout_in.nil? && token_authenticated_at && token_authenticated_at <= timeout_in.ago
    end

  end
end
