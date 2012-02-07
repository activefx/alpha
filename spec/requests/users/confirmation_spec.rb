require 'spec_helper'

describe "User confirmation" do

  if User.confirmable?

    it "occurs after following the confirmation link" do
      register("user@example.com", "password")
      page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
      @user = User.where(:email => "user@example.com").first
      visit user_confirmation_path(:confirmation_token => @user.confirmation_token)
      current_path.should == user_root_path
      page.should have_content I18n.t('devise.confirmations.confirmed')
    end

    describe "in beta", :beta do

      it "occurs after following the confirmation link" do
        register("user@example.com", "password", :invite_code => invite_code)
        page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
        @user = User.where(:email => "user@example.com").first
        visit user_confirmation_path(:confirmation_token => @user.confirmation_token)
        current_path.should == user_root_path
        page.should have_content I18n.t('devise.confirmations.confirmed')
      end

    end

  end

end

