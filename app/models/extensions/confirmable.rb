module Extensions
  module Confirmable
    extend ActiveSupport::Concern

    included do

      ## Confirmable fields
      field :confirmation_token,      :type => String
      field :confirmed_at,            :type => Time
      field :confirmation_sent_at,    :type => Time
      field :unconfirmed_email,       :type => String # Only if using reconfirmable

      devise :confirmable

      index({ confirmation_token: 1 }, { unique: true })

    end

  end
end 
