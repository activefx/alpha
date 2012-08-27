module Extensions
  module Lockable
    extend ActiveSupport::Concern

    included do

      # Lockable fields
      field :failed_attempts,         :type => Integer # Only if lock strategy is :failed_attempts
      field :unlock_token,            :type => String # Only if unlock strategy is :email or :both
      field :locked_at,               :type => Time

      # Options
      #  maximum_attempts:
      #    How many attempts should be accepted before blocking the user.
      #  lock_strategy:
      #    Lock the user account by :failed_attempts or :none.
      #  unlock_strategy:
      #    Unlock the user account by :time, :email, :both or :none.
      #  unlock_in:
      #    The time you want to lock the user after to lock happens. Only available when unlock_strategy is :time or :both.
      #  unlock_keys:
      #    The keys you want to use when locking and unlocking an account
      #
      devise :lockable

      index({ unlock_token: 1 }, { unique: true }) if has_unlock_token?

    end

    module ClassMethods

      def has_unlock_token?
        [:both, :email].include?(unlock_strategy)
      end

    end

    # Overwrites active_for_authentication? from Devise::Models::Activatable
    # for locking purposes by verifying whether a user is active to sign in
    # or not based on locked?
    #
    #  def active_for_authentication?
    #    super && !access_locked?
    #  end

  end
end 
