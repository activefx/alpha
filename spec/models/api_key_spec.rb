require 'spec_helper'

describe ApiKey do

  it { should be_mongoid_document }
  it { should be_timestamped_document }

  it { should have_field(:token).of_type(String) }

  it { should validate_presence_of(:token) }

  it { should_not allow_mass_assignment_of(:token) }

  context "#token" do
    let(:user) { create(:user) }
    let(:api_key) { user.create_api_key }

    it "is set on create" do
      api_key.token.should_not be_nil
    end

    it "is different each time" do
      api_key.token.should_not eq user.create_api_key.token
    end

    it "is not updated on save" do
      old_token = api_key.token
      api_key.save
      old_token.should eq api_key.token
    end
  end

end
