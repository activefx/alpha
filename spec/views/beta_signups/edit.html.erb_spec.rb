require 'spec_helper'

describe "beta_signups/edit.html.erb" do
  before(:each) do
    @beta_signup = assign(:beta_signup, stub_model(BetaSignup))
  end

  it "renders the edit beta_signup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_signups_path(@beta_signup), :method => "post" do
    end
  end
end
