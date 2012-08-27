module Extensions
  module Rememberable
    extend ActiveSupport::Concern

    included do

      # Rememberable fields
      field :remember_created_at,     :type => Time

      # Options
      #  remember_for:
      #    The time you want the user will be remembered without
      #    asking for credentials. After this time the user will be blocked and
      #    will have to enter his credentials again. This configuration is also
      #    used to calculate the expires time for the cookie created to remember
      #    the user. By default remember_for is 2.weeks.
      #  extend_remember_period:
      #    If true, extends the user's remember period
      #    when remembered via cookie. False by default.
      #  rememberable_options:
      #    Configuration options passed to the created cookie.
      #
      devise :rememberable

      attr_accessible :remember_me

    end

  end
end 
