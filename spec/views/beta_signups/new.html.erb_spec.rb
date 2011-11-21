require 'spec_helper'

describe "beta_signups/new.html.erb" do
  before(:each) do
    assign(:beta_signup, stub_model(BetaSignup).as_new_record)
  end

  it "renders new beta_signup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_signups_path, :method => "post" do
    end
  end
end
