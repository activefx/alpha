require 'spec_helper'

describe "User sign in" do

  before(:each) do
    @user = Factory(:user)
  end

  it "is allowed with valid information" do
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
    current_path.should == root_path
    page.has_content? "Signed in successfully"
  end

end

