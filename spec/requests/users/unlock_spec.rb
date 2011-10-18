require 'spec_helper'

describe "User forget password" do

  if User.lockable? && [:both, :email].include?(User.unlock_strategy)

    before(:each) do
      @user = Factory(:user)
    end

    it "enables changing password after following email link" do
      @user.lock_access!
      visit new_user_unlock_path
      fill_in "Email", :with => @user.email
      click_button "Resend unlock instructions"
      visit user_unlock_path(@user, :unlock_token => @user.unlock_token)
      page.has_content? "Your account was successfully unlocked. You are now signed in."
    end

  end

end

