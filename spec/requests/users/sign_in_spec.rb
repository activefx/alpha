require 'spec_helper'

describe "User sign in" do

  describe do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "is allowed with valid information" do
      login_user(@user)
      current_path.should == user_root_path
      page.should have_content I18n.t('devise.sessions.signed_in')
    end

  end

  describe "in beta", :beta do

    before(:each) do
      @invite_code = FactoryGirl.create(:invite_code)
      @user = FactoryGirl.create(:user, :invite_code => @invite_code.token)
    end

    it "is allowed with valid information" do
      login_user(@user)
      current_path.should == user_root_path
      page.should have_content I18n.t('devise.sessions.signed_in')
    end

  end

end

