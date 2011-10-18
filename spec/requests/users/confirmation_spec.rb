require 'spec_helper'

describe "User confirmation" do

  if User.confirmable?

    it "occurs after following the confirmation link" do
      visit new_user_registration_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
      fill_in "Confirm password", :with => "password"
      click_button "Sign up"
      @user = User.where(:email => "user@example.com").first
      visit user_confirmation_path(@user, :confirmation_token => @user.confirmation_token)
      page.has_content? "Your account was successfully confirmed"
    end

  end

end

