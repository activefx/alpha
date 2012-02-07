require 'spec_helper'

describe "Admin users dashboard" do

  before(:all) do
    @admin = Factory(:admin)
    25.times do
      Factory(:user)
    end
  end

  before(:each) do
    login_user(@admin)
    visit admin_users_path
  end

  it "shows a list of users" do
    page.should have_content "Email"
  end


end

