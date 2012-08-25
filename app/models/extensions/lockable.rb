module Extensions
  module Lockable
    extend ActiveSupport::Concern

    included do

      ## Lockable
      field :failed_attempts,         :type => Integer # Only if lock strategy is :failed_attempts
      field :unlock_token,            :type => String # Only if unlock strategy is :email or :both
      field :locked_at,               :type => Time

      devise :lockable

      index({ unlock_token: 1 }, { unique: true }) if has_unlock_token?

    end

    module ClassMethods

      def has_unlock_token?
        [:both, :email].include?(unlock_strategy)
      end

    end

  end
end 
