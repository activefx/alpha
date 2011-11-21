require 'spec_helper'

describe "beta_signups/index.html.erb" do
  before(:each) do
    assign(:beta_signups, [
      stub_model(BetaSignup),
      stub_model(BetaSignup)
    ])
  end

  it "renders a list of beta_signups" do
    render
  end
end
