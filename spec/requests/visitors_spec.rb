require 'spec_helper'

describe "Visitors" do

  it "are on the homepage" do
    visit root_path
    page.status_code.should be(200)
  end

  it "are redirected to the landing page", :beta do
    visit root_path
    current_path.should == beta_signups_path
    page.should have_content "Register"
    page.should have_content "Sign In"
  end

  describe "on the hompage" do

    it "see a sign in link" do
      visit root_path
      click_link "Sign In"
      page.should have_field "Email"
      page.should have_field "Password"
    end

    it "see a sign up link" do
      visit root_path
      click_link "Register"
      page.should have_field "Email"
      page.should have_field "Password"
      page.should have_field "Confirm password"
    end

  end

end

