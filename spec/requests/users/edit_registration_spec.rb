require 'spec_helper'

describe "User edit registration" do

  before(:each) do
    @user = Factory(:user)
    login_user(@user)
    visit edit_user_registration_path(@user)
  end

  it "allows for changing the email" do
    fill_in "Email", :with => "newemail@example.com"
    click_button "Update"
    page.has_content? I18n.t('devise.registrations.updated')
  end

  it "allows for changing the password" do
    fill_in "Password", :with => "new password"
    fill_in "Confirm password", :with => "new password"
    fill_in "Current password", :with => @user.password
    click_button "Update"
    page.has_content? I18n.t('devise.registrations.updated')
  end

  it "allows for canceling the account" do
    click_link "Cancel my account"
    current_path.should == root_path
    page.has_content? I18n.t('devise.registrations.destroyed')
    login_user(@user)
    page.has_content? I18n.t('devise.failure.invalid')
  end


end

