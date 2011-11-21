require 'spec_helper'

describe "beta_signups/edit.html.haml" do
  before(:each) do
    @beta_signup = assign(:beta_signup, stub_model(BetaSignup,
      :email => "MyString"
    ))
  end

  it "renders the edit beta_signup form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_signups_path(@beta_signup), :method => "post" do
      assert_select "input#beta_signup_email", :name => "beta_signup[email]"
    end
  end
end
