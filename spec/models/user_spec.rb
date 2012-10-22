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

  context "associations" do
    it { should embed_many(:api_keys) }
  end

  context "indexes" do
    it { should have_index_for({'api_keys.token' => 1}).with_options(:unique => true) }
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
    it { should be_timeoutable }
    it { should be_token_authenticatable }
    it { should be_trackable }
    it { should be_validatable }

  end

  context "api" do

    it { should have_field(:monthly_api_rate_limit).of_type(Integer) }
    it { should have_field(:daily_api_rate_limit).of_type(Integer) }
    it { should have_field(:hourly_api_rate_limit).of_type(Integer) }

    it { should_not allow_mass_assignment_of(:monthly_api_rate_limit) }
    it { should_not allow_mass_assignment_of(:daily_api_rate_limit) }
    it { should_not allow_mass_assignment_of(:hourly_api_rate_limit) }

  end

end
