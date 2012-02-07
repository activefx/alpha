require 'spec_helper'

describe "Twitter authentication" do

  if User.omniauthable? && Devise.omniauth_providers.include?(:twitter)

    it "creates a new user when successful", :omniauth do
      stub_twitter
      visit new_user_session_path
      click_link "Sign in with Twitter"
      current_path.should == new_user_registration_path
      page.should have_content "Please complete your registration."
      page.should have_content "Sign In"
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
      fill_in "Confirm password", :with => "password"
      click_button "Sign up"
      current_path.should == root_path
      page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
      # User still has to confirm their account
      page.should have_content "Sign In"
      user = User.where(:email => "user@example.com").first
      user.should_not be_nil
      user.authentications.where(:provider => "twitter", :uid => "444444").count.should == 1
    end

  end
end

