module Extensions
  module Recoverable
    extend ActiveSupport::Concern

    included do

      # Recoverable fields
      field :reset_password_token,    :type => String
      field :reset_password_sent_at,  :type => Time

      # Options
      #  reset_password_keys:
      #    The keys you want to use when recovering the password for an account
      #
      devise :recoverable

      index({ reset_password_token: 1 }, { unique: true })

    end

  end
end 
