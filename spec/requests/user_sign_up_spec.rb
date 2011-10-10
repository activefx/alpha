require 'spec_helper'

describe "User sign up" do

  it "is allowed with valid information" do
    visit new_user_registration_path
    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Confirm password", :with => "password"
    click_button "Sign up"
    current_path.should == root_path
    page.has_content? "You have signed up successfully"
  end

  it "fails with invalid information" do
    visit new_user_registration_path
    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Confirm password", :with => "different password"
    click_button "Sign up"
    page.has_content? "Some errors were found"
  end

end

