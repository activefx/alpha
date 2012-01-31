require 'spec_helper'

describe "Omniauth authentication" do

  if User.omniauthable? && Devise.omniauth_providers.include?(:facebook)

    # Add your own Facebook authentication tests here,
    # currently only mirrors the omniauth integration spec
    it "creates a new user when successful", :omniauth do
      stub_facebook
      visit new_user_session_path
      click_link "Sign in with Facebook"
      current_path.should == user_root_path
      page.should have_content I18n.t('devise.omniauth_callbacks.success', :kind => 'Facebook')
      page.should have_content "Sign Out"
      user = User.where(:email => "joe@bloggs.com").first
      user.should_not be_nil
      user.authentications.where(:provider => "facebook", :uid => "111111").count.should == 1
    end

  end
end

