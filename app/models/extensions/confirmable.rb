module Extensions
  module Confirmable
    extend ActiveSupport::Concern

    included do

      # Confirmable fields
      field :confirmation_token,      :type => String
      field :confirmed_at,            :type => Time
      field :confirmation_sent_at,    :type => Time
      field :unconfirmed_email,       :type => String # Only if using reconfirmable

      # Options
      #  allow_unconfirmed_access_for:
      #    The time you want to allow the user to access his account before confirming it.
      #    After this period, the user access is denied. You can use this to let your user
      #    access some features of your application without confirming the account, but
      #    blocking it after a certain period (ie 7 days). By default allow_unconfirmed_access_for
      #    is zero, it means users always have to confirm to sign in.
      #  reconfirmable:
      #    Requires any email changes to be confirmed (exactly the same way as initial account
      #    confirmation) to be applied. Requires additional unconfirmed_email db field to be
      #    setup (t.reconfirmable in migrations). Until confirmed new email is stored in
      #    unconfirmed email column, and copied to email column on successful confirmation.
      #  confirm_within:
      #    The time before a sent confirmation token becomes invalid.
      #    You can use this to force the user to confirm within a set period of time.
      #
      devise :confirmable

      index({ confirmation_token: 1 }, { unique: true })

    end

    # Overwrites active_for_authentication? for confirmation by verifying whether a
    # user is active to sign in or not. If the user is already confirmed, it should
    # never be blocked. Otherwise we need to calculate if the confirm time has not
    # expired for this user.
    #
    #  def active_for_authentication?
    #    super && (!confirmation_required? || confirmed? || confirmation_period_valid?)
    #  end

  end
end 
