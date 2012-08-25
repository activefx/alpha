module Extensions
  module DatabaseAuthenticatable
    extend ActiveSupport::Concern

    included do

      ## Database authenticatable fields
      field :email,                   :type => String
      field :encrypted_password,      :type => String

      devise :database_authenticatable

      attr_accessible :email, :password, :password_confirmation

      index({ email: 1 }, { unique: true })

    end

  end
end 
