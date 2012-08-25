module Extensions
  module BetaSignups
    extend ActiveSupport::Concern

    included do

      ## Beta signup fields
      field :invite_code,             :type => String

      attr_accessible :invite_code

      validates :invite_code, :presence => true, :if => :beta_user_signup?

      validate :invitation_token_validity

    end

    def beta_user_signup?
      site_in_beta? && !persisted?
    end

    def site_in_beta?
      configatron.in_beta == true
    end

    def invitation_token_validity
      if beta_user_signup?
        token = InviteCode.where(token: invite_code).first
        unless token && token.invitation_accepted_at.nil?
          errors[:invite_code] << "was not valid"
        end
        if token && token.invitation_sent_to == email
          skip_confirmation!
        end
      end
    end

  end
end 
