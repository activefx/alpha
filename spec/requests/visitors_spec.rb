require 'spec_helper'

describe "Visitors" do

  describe "hompage" do

    it "sends visitors to the application root" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit root_path
      page.status_code.should be(200)
    end

#    it "has a sign in link" do
#      visit root_path
#      click_link "Sign In"
#      page.should have_field("login")
#      page.should have_field("password")
#    end

#    it "has a sign up link" do
#      visit root_path
#      click_link "Sign Up"
#      page.should have_field("email")
#      page.should have_field("password")
#      page.should have_field("password_confirmation")
#    end

  end

end

