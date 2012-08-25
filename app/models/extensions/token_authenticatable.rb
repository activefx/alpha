module Extensions
  module TokenAuthenticable
    extend ActiveSupport::Concern

    included do

      ## Token authenticatable fields
      field :authentication_token,    :type => String

      devise :token_authenticatable

      index({ authentication_token: 1 }, { unique: true })

    end

  end
end 
