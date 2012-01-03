module Users
  class PasswordsController < Devise::PasswordsController

    skip_before_filter :show_beta_page?

  end
end

