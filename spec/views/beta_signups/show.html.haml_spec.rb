require 'spec_helper'

describe "beta_signups/show.html.haml" do
  before(:each) do
    @beta_signup = assign(:beta_signup, stub_model(BetaSignup,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
  end
end
