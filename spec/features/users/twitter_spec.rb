require 'spec_helper'

describe "Twitter authentication" do

  if User.omniauthable? && Devise.omniauth_providers.include?(:twitter)

    it "requires registration when creating a new user and email and password is required", :omniauth do
      configatron.temp do
        configatron.omniauth.require_email = true
        configatron.omniauth.require_password = true
        stub_twitter
        visit new_user_session_path
        click_link "Sign in with Twitter"
        current_path.should == new_user_registration_path
        page.should have_content I18n.t('devise.registrations.finish')
        page.should have_content I18n.t('devise.sign_in')
        fill_in "Email", :with => "user1@example.com"
        fill_in "Password", :with => "password"
        fill_in "Confirm password", :with => "password"
        click_button I18n.t('devise.sign_up')
        current_path.should == root_path
        page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
        # User still has to confirm their account
        page.should have_content I18n.t('devise.sign_in')
        user = User.where(:email => "user1@example.com").first
        user.should_not be_nil
        user.authentications.where(:provider => "twitter", :uid => "144333836").count.should == 1
      end
    end

    it "requires registration when creating a new user and email is required", :omniauth do
      configatron.temp do
        configatron.omniauth.require_email = true
        configatron.omniauth.require_password = false
        stub_twitter
        visit new_user_session_path
        click_link "Sign in with Twitter"
        current_path.should == new_user_registration_path
        page.should have_content I18n.t('devise.registrations.finish')
        page.should have_content I18n.t('devise.sign_in')
        fill_in "Email", :with => "user2@example.com"
        click_button I18n.t('devise.sign_up')
        current_path.should == root_path
        page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
        # User still has to confirm their account
        page.should have_content I18n.t('devise.sign_in')
        user = User.where(:email => "user2@example.com").first
        user.should_not be_nil
        user.authentications.where(:provider => "twitter", :uid => "144333836").count.should == 1
      end
    end

    it "requires registration when creating a new user and password is required", :omniauth do
      configatron.temp do
        configatron.omniauth.require_email = false
        configatron.omniauth.require_password = true
        stub_twitter
        visit new_user_session_path
        click_link "Sign in with Twitter"
        current_path.should == new_user_registration_path
        page.should have_content I18n.t('devise.registrations.finish')
        page.should have_content I18n.t('devise.sign_in')
        fill_in "Password", :with => "password"
        fill_in "Confirm password", :with => "password"
        click_button I18n.t('devise.sign_up')
        current_path.should == user_root_path
        page.should have_content I18n.t('devise.registrations.signed_up')
        page.should have_content I18n.t('devise.sign_out')
        user = User.where(:username => "mattsolt").first
        user.should_not be_nil
        user.authentications.where(:provider => "twitter", :uid => "144333836").count.should == 1
      end
    end

    it "registers a user when email and password are not required", :omniauth do
      configatron.temp do
        configatron.omniauth.require_email = false
        configatron.omniauth.require_password = false
        stub_twitter
        visit new_user_session_path
        click_link "Sign in with Twitter"
        current_path.should == user_root_path
        page.should have_content I18n.t('devise.omniauth_callbacks.success', :kind => 'Twitter')
        page.should have_content I18n.t('devise.sign_out')
        user = User.where(:username => "mattsolt").first
        user.should_not be_nil
        user.authentications.where(:provider => "twitter", :uid => "144333836").count.should == 1
      end
    end

    it "can be added to a logged in user's third party authentications", :omniauth do
      stub_twitter
      @user = FactoryGirl.create(:user)
      login_user @user
      visit edit_user_registration_path
      click_link "Add Twitter authentication"
      page.should have_content I18n.t('devise.omniauth_callbacks.added', :kind => 'Twitter')
      current_path.should == edit_user_registration_path
      @user.authentications.where(:provider => "twitter", :uid => "144333836").count.should == 1
    end

    it "allows logging out", :omniauth do
      configatron.temp do
        configatron.omniauth.require_email = false
        configatron.omniauth.require_password = false
        stub_twitter
        visit new_user_session_path
        click_link "Sign in with Twitter"
        current_path.should == user_root_path
        logout_user
        current_path.should == root_path
        page.should have_content I18n.t('devise.sign_in')
      end
    end

    it "fails with invalid credentials", :omniauth do
      stub_invalid_credentials(:twitter)
      visit new_user_session_path
      click_link "Sign in with Twitter"
      current_path.should == new_user_session_path
      page.should have_content I18n.t('devise.omniauth_callbacks.failure', :kind => 'Twitter', :reason => 'of invalid credentials')
      page.should have_content "Sign In"
    end

    it "fails with invalid response", :omniauth do
      stub_invalid_response(:twitter)
      visit new_user_session_path
      click_link "Sign in with Twitter"
      current_path.should == new_user_session_path
      page.should have_content I18n.t('devise.omniauth_callbacks.failure', :kind => 'Twitter', :reason => 'of invalid response')
      page.should have_content "Sign In"
    end

    it "fails with timeout", :omniauth do
      stub_timeout(:twitter)
      visit new_user_session_path
      click_link "Sign in with Twitter"
      current_path.should == new_user_session_path
      page.should have_content I18n.t('devise.omniauth_callbacks.failure', :kind => 'Twitter', :reason => 'the service failed to respond')
      page.should have_content "Sign In"
    end


#    it "signs in an existing user if the email addresses match", :omniauth do
#      FactoryGirl.create(:user, :email => "joe@bloggs.com")
#      stub_facebook
#      visit new_user_session_path
#      click_link "Sign in with Facebook"
#      current_path.should == user_root_path
#      page.should have_content I18n.t('devise.omniauth_callbacks.success', :kind => 'Facebook')
#      page.should have_content "Sign Out"
#      user = User.where(:email => "joe@bloggs.com").first
#      user.should_not be_nil
#      user.authentications.where(:provider => "facebook", :uid => "111111").count.should == 1
#    end

#    it "signs in an existing user if they used this authentication before", :omniauth do
#      existing_user = FactoryGirl.create(:user, :email => "joe@bloggs.com")
#      existing_user.authentications.create(:provider => "facebook", :uid => "111111")
#      stub_facebook
#      visit new_user_session_path
#      click_link "Sign in with Facebook"
#      current_path.should == user_root_path
#      page.should have_content I18n.t('devise.omniauth_callbacks.success', :kind => 'Facebook')
#      page.should have_content "Sign Out"
#      user = User.where(:email => "joe@bloggs.com").first
#      user.should_not be_nil
#      user.authentications.where(:provider => "facebook", :uid => "111111").count.should == 1
#    end

#    it "requests additional registration information when required", :omniauth do
#      configatron.temp do
#        configatron.omniauth.enable_password_authentication = true
#        stub_facebook
#        visit new_user_session_path
#        click_link "Sign in with Facebook"
#        current_path.should == new_user_registration_path
#        page.should have_content "Please complete your registration."
#        page.should have_content "Sign In"
#        fill_in "Password", :with => "password"
#        fill_in "Confirm password", :with => "password"
#        click_button "Sign up"
#        current_path.should == user_root_path
#        page.should have_content I18n.t('devise.registrations.signed_up')
#        user = User.where(:email => "joe@bloggs.com").first
#        user.should_not be_nil
#        user.authentications.where(:provider => 'facebook', :uid => "111111").count.should == 1
#      end
#    end

#    it "logs out a user", :omniauth do
#      stub_facebook
#      visit new_user_session_path
#      click_link "Sign in with Facebook"
#      click_link "Sign Out"
#      current_path.should == root_path
#      page.should have_content I18n.t('devise.sessions.signed_out')
#    end

#    it "fails with invalid credentials", :omniauth do
#      stub_invalid_credentials(:facebook)
#      visit new_user_session_path
#      click_link "Sign in with Facebook"
#      current_path.should == new_user_session_path
#      page.should have_content I18n.t('devise.omniauth_callbacks.failure', :kind => 'Facebook', :reason => 'of invalid credentials')
#      page.should have_content "Sign In"
#    end

#    it "fails with invalid response", :omniauth do
#      stub_invalid_response(:facebook)
#      visit new_user_session_path
#      click_link "Sign in with Facebook"
#      current_path.should == new_user_session_path
#      page.should have_content I18n.t('devise.omniauth_callbacks.failure', :kind => 'Facebook', :reason => 'of invalid response')
#      page.should have_content "Sign In"
#    end

#    it "fails with timeout", :omniauth do
#      stub_timeout(:facebook)
#      visit new_user_session_path
#      click_link "Sign in with Facebook"
#      current_path.should == new_user_session_path
#      page.should have_content I18n.t('devise.omniauth_callbacks.failure', :kind => 'Facebook', :reason => 'the service failed to respond')
#      page.should have_content "Sign In"
#    end

#  end

#  if User.omniauthable? && Devise.omniauth_providers.include?(:twitter)

#    it "creates a new user when successful", :omniauth do
#      stub_twitter
#      visit new_user_session_path
#      click_link "Sign in with Twitter"
#      current_path.should == new_user_registration_path
#      page.should have_content "Please complete your registration."
#      page.should have_content "Sign In"
#      fill_in "Email", :with => "user@example.com"
#      fill_in "Password", :with => "password"
#      fill_in "Confirm password", :with => "password"
#      click_button "Sign up"
#      current_path.should == root_path
#      page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
#      # User still has to confirm their account
#      page.should have_content "Sign In"
#      user = User.where(:email => "user@example.com").first
#      user.should_not be_nil
#      user.authentications.where(:provider => "twitter", :uid => "444444").count.should == 1
#    end

  end
end
