module Users
  class UnlocksController < Devise::UnlocksController

    skip_before_filter :show_beta_page?

  end
end

