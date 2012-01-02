require 'spec_helper'

describe "Visitors to the beta site" do

  it "should be redirected to the landing page", :beta do
    visit root_path
    current_path.should == beta_signups_path
  end

end

