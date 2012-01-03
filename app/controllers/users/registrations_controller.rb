module Users
  class RegistrationsController < Devise::RegistrationsController

    skip_before_filter :show_beta_page?

    protected

    def after_inactive_sign_up_path_for(resource)
      if site_in_beta?
        beta_signups_path
      else
        root_path
      end
    end

  end
end

