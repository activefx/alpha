module Users
  class SessionsController < Devise::SessionsController

    skip_before_filter :show_beta_page?

  end
end

