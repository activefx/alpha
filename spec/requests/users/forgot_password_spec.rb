require 'spec_helper'

describe "User forget password" do

  if User.recoverable?

    describe do

      before(:each) do
        @user = FactoryGirl.create(:user)
      end

      it "sends an email with instructions" do
        visit new_user_password_path
        fill_in "Email", :with => @user.email
        click_button "Reset password"
        current_path.should == new_user_session_path
        page.has_content? I18n.t('devise.passwords.send_instructions')
      end

      it "enables changing password after following email link" do
        @user.send("generate_reset_password_token!")
        visit edit_user_password_path(:reset_password_token => @user.reset_password_token)
        fill_in "New password", :with => "password"
        fill_in "Confirm your new password", :with => "password"
        click_button "Change my password"
        current_path.should == user_root_path
        page.should have_content I18n.t('devise.passwords.updated')
      end

    end

    describe "in beta", :beta do

      before(:each) do
        @invite_code = FactoryGirl.create(:invite_code)
        @user = FactoryGirl.create(:user, :invite_code => @invite_code.token)
      end

      it "enables changing password after following email link" do
        @user.send("generate_reset_password_token!")
        visit edit_user_password_path(:reset_password_token => @user.reset_password_token)
        fill_in "New password", :with => "password"
        fill_in "Confirm your new password", :with => "password"
        click_button "Change my password"
        current_path.should == user_root_path
        page.should have_content I18n.t('devise.passwords.updated')
      end

    end

  end

end

