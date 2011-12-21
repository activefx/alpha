module Admin
  class BetaSignupsController < Admin::BaseController

    def index
      @beta_signups = BetaSignup.all
    end

  end
end

