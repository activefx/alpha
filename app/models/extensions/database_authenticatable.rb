module Extensions
  module DatabaseAuthenticatable
    extend ActiveSupport::Concern

    included do

      # Database authenticatable fields
      field :email,                   :type => String,    :default => ""
      field :encrypted_password,      :type => String,    :default => ""

      # Options
      #  pepper:
      #    A random string used to provide a more secure hash. Use
      #      `rake secret` to generate new keys.
      #    stretches:
      #      The cost given to bcrypt.
      #
      devise :database_authenticatable

      attr_accessible :email, :password, :password_confirmation

      index({ email: 1 }, { unique: true })

    end

    # Hook called after database authentication.
    #
    #  def after_database_authentication
    #  end

    # Updates record attributes without asking for the current password.
    # Never allows to change the current password. If you are using this
    # method, you should probably override this method to protect other
    # attributes you would not like to be updated without a password.
    #
    #  def update_without_password(params={})
    #    params.delete(:email)
    #    super(params)
    #  end

  end
end
