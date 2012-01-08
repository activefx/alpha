require 'spec_helper'

describe "Facebook authentication" do

  if User.omniauthable? && Devise.omniauth_providers.include?(:facebook)

    it "creates a new user when successful", :omniauth do
      stub_facebook
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == user_root_path
      page.should have_content "Successfully authorized from Facebook account."
      page.should have_content "Sign Out"
      user = User.where(:email => "joe@bloggs.com").first
      user.should_not be_nil
      user.authentications.where(:provider => "facebook", :uid => "1234567").count.should == 1
    end

    it "signs in an existing user if the email addresses match", :omniauth do
      Factory(:user, :email => "joe@bloggs.com")
      stub_facebook
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == user_root_path
      page.should have_content "Successfully authorized from Facebook account."
      page.should have_content "Sign Out"
      user = User.where(:email => "joe@bloggs.com").first
      user.should_not be_nil
      user.authentications.where(:provider => "facebook", :uid => "1234567").count.should == 1
    end

    it "signs in an existing user if they used this authentication before", :omniauth do
      existing_user = Factory(:user, :email => "joe@bloggs.com")
      existing_user.authentications.create(:provider => "facebook", :uid => "1234567")
      stub_facebook
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == user_root_path
      page.should have_content "Successfully authorized from Facebook account."
      page.should have_content "Sign Out"
      user = User.where(:email => "joe@bloggs.com").first
      user.should_not be_nil
      user.authentications.where(:provider => "facebook", :uid => "1234567").count.should == 1
    end

    it "requests additional registration information when required", :omniauth do
      configatron.temp do
        configatron.omniauth.enable_password_authentication = true
        stub_facebook
        visit new_user_session_path
        click_link "Sign in with Facebook"
        current_path.should == new_user_registration_path
        page.should have_content "Please complete your registration."
        page.should have_content "Sign In"
        fill_in "Password", :with => "password"
        fill_in "Confirm password", :with => "password"
        click_button "Sign up"
        current_path.should == user_root_path
        page.should have_content "You have signed up successfully"
        user = User.where(:email => "joe@bloggs.com").first
        user.should_not be_nil
        user.authentications.where(:provider => 'facebook').count.should == 1
      end
    end

    it "fails with invalid credentials", :omniauth do
      stub_invalid_credentials(:facebook)
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == new_user_session_path
      page.should have_content "Could not authorize you from Facebook because of invalid credentials."
      page.should have_content "Sign In"
    end

    it "fails with invalid response", :omniauth do
      stub_invalid_response(:facebook)
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == new_user_session_path
      page.should have_content "Could not authorize you from Facebook because of invalid response."
      page.should have_content "Sign In"
    end

    it "fails with timeout", :omniauth do
      stub_timeout(:facebook)
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == new_user_session_path
      page.should have_content "Could not authorize you from Facebook because the service failed to respond."
      page.should have_content "Sign In"
    end



#    it "enables changing password after following email link" do
#      @user.send("generate_reset_password_token!")
#      visit edit_user_password_path(@user, :reset_password_token => @user.reset_password_token)
#      fill_in "New password", :with => "password"
#      fill_in "Confirm your new password", :with => "password"
#      click_button "Change my password"
#      current_path.should == user_root_path
#      page.has_content? "Your password was changed successfully. You are now signed in."
#    end

#  Scenario: Facebook First Login (required user information is included)
#    When I login with facebook
#    Then I should see "Successfully authorized from facebook account."
#    And I should see "Signed in as josevalim"
#    And "user456@example.com" should have been created by omniauth

#  Scenario: Facebook First Login (user already has an account)
#    When I have a user with email "user456@example.com"
#    And I login with facebook
#    Then I should see "Successfully authorized from facebook account."
#    And I should see "Signed in as person"
#    And "user456@example.com" should not have been created by omniauth

#  Scenario: Unsuccessful Facebook Login (invalid credentials)
#    When I fail to login with facebook due to invalid credentials
#    Then I should see "Could not authorize you from Facebook"
#    And I should be on the login page
#    And I should not be logged in

#  Scenario: Unsuccessful Facebook Login (access denied)
#    When I fail to login with facebook due to access denied
#    Then I should see "Could not authorize you from Facebook"
#    And I should be on the login page
#    And I should not be logged in

#  Scenario: Facebook Logout
#    When I am logged in with facebook
#    And I follow "Sign Out"
#    Then I should be on the home page
#    And I should not be logged in

  end

end

