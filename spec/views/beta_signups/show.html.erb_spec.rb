require 'spec_helper'

describe "beta_signups/show.html.erb" do
  before(:each) do
    @beta_signup = assign(:beta_signup, stub_model(BetaSignup))
  end

  it "renders attributes in <p>" do
    render
  end
end
