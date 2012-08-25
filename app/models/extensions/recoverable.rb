module Extensions
  module Recoverable
    extend ActiveSupport::Concern

    included do

      ## Recoverable fields
      field :reset_password_token,    :type => String
      field :reset_password_sent_at,  :type => Time

      devise :recoverable

    end

  end
end 
