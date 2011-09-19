require 'spec_helper'

describe User do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:created_by_omniauth).of_type(Boolean).with_default_value_of(false) }
  it { Factory.build(:user).should be_valid }

  it_should_behave_like "a devise model"

  context "data model" do

    it { should_not allow_mass_assignment_of(:id => 1) }
    it { should allow_mass_assignment_of(:email => "email@example.com") }
    it { should allow_mass_assignment_of(:password => "password") }
    it { should allow_mass_assignment_of(:password_confirmation => "password") }
    it { should allow_mass_assignment_of(:remember_me => true) }
    it { should_not allow_mass_assignment_of(:created_by_omniauth => true) }

  end

  context "application specific devise configuration" do

    it { should be_confirmable }
    it { should be_database_authenticatable }
    it { should_not be_encryptable }
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

