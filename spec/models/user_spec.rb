require 'spec_helper'

describe User do

  it { should be_mongoid_document }
  it { should be_timestamped_document }

  it_should_behave_like "a devise model"

  context "data model" do

    it { should have_field(:username).of_type(String) }

    it { should_not allow_mass_assignment_of(:id) }
    it { should allow_mass_assignment_of(:username) }

  end

  context "validations" do
    it { FactoryGirl.build(:user).should be_valid }
  end

  context "application specific devise configuration" do

    it { should be_confirmable }
    it { should be_database_authenticatable }
    it { should be_lockable }
    it { should be_omniauthable }
    it { should be_recoverable }
    it { should be_registerable }
    it { should be_rememberable }
    it { should_not be_timeoutable }
    it { should_not be_token_authenticatable }
    it { should be_trackable }
    it { should be_validatable }

  end

end
