require 'spec_helper'

describe "Visitors" do

  describe "on the hompage" do

    it "are on the application root" do
      visit root_path
      page.status_code.should be(200)
    end

    it "see a sign in link" do
      visit root_path
      click_link "Sign In"
      page.has_field?("Email")
      page.has_field?("Password")
    end

    it "see a sign up link" do
      visit root_path
      click_link "Sign Up"
      page.has_field?("Email")
      page.has_field?("Password")
      page.has_field?("Password Confirmation")
    end

  end

end

