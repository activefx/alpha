require 'spec_helper'

describe "User forget password" do

  if User.lockable? && [:both, :email].include?(User.unlock_strategy)

    describe do

      before(:each) do
        @user = FactoryGirl.create(:user)
      end

      it "enables changing password after following email link" do
        @user.lock_access!
        visit new_user_unlock_path
        fill_in "Email", :with => @user.email
        click_button "Resend unlock instructions"
        visit user_unlock_path(:unlock_token => @user.unlock_token)
        page.should have_content I18n.t('devise.unlocks.unlocked')
      end

    end

    describe "in beta", :beta do

      before(:each) do
        @invite_code = FactoryGirl.create(:invite_code)
        @user = FactoryGirl.create(:user, :invite_code => @invite_code.token)
      end

      it "enables changing password after following email link" do
        @user.lock_access!
        visit new_user_unlock_path
        fill_in "Email", :with => @user.email
        click_button "Resend unlock instructions"
        visit user_unlock_path(:unlock_token => @user.unlock_token)
        page.should have_content I18n.t('devise.unlocks.unlocked')
      end

    end

  end

end

