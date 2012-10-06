require 'spec_helper'

describe Administrator do

  it { should be_mongoid_document }
  it { should be_timestamped_document }

  it_should_behave_like "a devise model"

  context "data model" do

    it { should_not allow_mass_assignment_of(:id) }

  end

  context "validations" do

    it { FactoryGirl.build(:admin).should be_valid }

  end

  context "application specific devise configuration" do

    it { should_not be_confirmable }
    it { should be_database_authenticatable }
    it { should be_lockable }
    it { should_not be_omniauthable }
    it { should_not be_recoverable }
    it { should_not be_registerable }
    it { should_not be_rememberable }
    it { should be_timeoutable }
    it { should_not be_token_authenticatable }
    it { should be_trackable }
    it { should be_validatable }

  end


end

