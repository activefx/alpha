module Users
  class ConfirmationsController < Devise::ConfirmationsController

    skip_before_filter :show_beta_page?

  end
end

