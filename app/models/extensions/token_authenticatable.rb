module Extensions
  module TokenAuthenticable
    extend ActiveSupport::Concern

    included do

      # Token authenticatable fields
      field :authentication_token,    :type => String

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
      #  before_save :ensure_authentication_token

      index({ authentication_token: 1 }, { unique: true })

    end

    # Hook called after token authentication.
    # Useful for deleting the token after it is used.
    #
    #  def after_token_authentication
    #  end

  end
end 
