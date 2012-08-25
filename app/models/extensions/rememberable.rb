module Extensions
  module Rememberable
    extend ActiveSupport::Concern

    included do

      ## Rememberable fields
      field :remember_token,          :type => String
      field :remember_created_at,     :type => Time

      devise :rememberable

      attr_accessible :remember_me

    end

  end
end 
