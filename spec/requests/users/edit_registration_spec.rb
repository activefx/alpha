require 'spec_helper'

describe "User edit registration" do

  before(:each) do
    @user = FactoryGirl.create(:user, :password => "password", :password_confirmation => "password")
    login_user(@user)
    visit edit_user_registration_path(@user)
  end

  it "allows for changing the email" do
    fill_in "Email", :with => "newemail@example.com"
    fill_in "Current password", :with => "password"
    click_button "Update"
    page.should have_content I18n.t('devise.registrations.updated')
  end

  it "allows for changing the password" do
    fill_in "Password", :with => "new password"
    fill_in "Confirm password", :with => "new password"
    fill_in "Current password", :with => "password"
    click_button "Update"
    page.should have_content I18n.t('devise.registrations.updated')
  end

  it "allows for canceling the account" do
    click_link "Cancel my account"
    current_path.should == root_path
    page.should have_content I18n.t('devise.registrations.destroyed')
    login_user(@user)
    page.should have_content I18n.t('devise.failure.invalid')
  end


end

