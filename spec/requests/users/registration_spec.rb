require 'spec_helper'

describe "User registration" do

  it "is allowed with valid information" do
    register("user@example.com", "password")
    current_path.should == root_path
    page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  it "fails with invalid information" do
    visit new_user_registration_path
    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Confirm password", :with => "different password"
    click_button "Sign up"
    page.should have_content "Some errors were found"
  end

  describe "in beta", :beta do

    it "requires an invite code" do
      visit new_user_registration_path
      page.should have_field "Invite code"
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
      fill_in "Confirm password", :with => "password"
      click_button "Sign up"
      page.should have_content "Some errors were found"
    end

    it "is allowed with valid invite code" do
      register("user@example.com", "password", :invite_code => invite_code)
      current_path.should == beta_signups_path
      page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
    end

    it "fails with an invalid invite code" do
      register("user@example.com", "password", :invite_code => "Invalid Invite Code")
      page.should have_content "Some errors were found"
    end

    it "cofirms the user when email matches the invite code" do
      token = invite_code(:invitation_sent_to => "user@example.com")
      register("user@example.com", "password", :invite_code => token)
      current_path.should == user_root_path
      page.should have_content I18n.t('devise.registrations.signed_up')
    end

  end

end

