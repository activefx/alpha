require 'spec_helper'

describe "beta_signups/index.html.haml" do
  before(:each) do
    assign(:beta_signups, [
      stub_model(BetaSignup,
        :email => "Email"
      ),
      stub_model(BetaSignup,
        :email => "Email"
      )
    ])
  end

  it "renders a list of beta_signups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
