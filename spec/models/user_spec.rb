require 'spec_helper'

describe User do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should have_field(:created_by_omniauth).of_type(Boolean).with_default_value_of(false) }
  it { FactoryGirl.build(:user).should be_valid }
  it { should have_many(:authentications).with_dependent(:destroy).with_autosave }

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


#  describe User do
#    it "should be valid" do
#      Fabricate.build(:user).should be_valid
#    end
#    it { should have_field(:email).of_type(String) }
#    it { should have_field(:login).of_type(String) }

#    it { should embed_many(:user_tokens).of_type(UserToken) }

#    it { should validate_presence_of(:login) }
#    it { should validate_uniqueness_of(:email) }
#    it { should validate_uniqueness_of(:login) }

#    describe ".find_for_database_authentication" do
#      let(:user) { Fabricate(:user) }

#      it 'should return user by email' do
#        User.find_for_database_authentication(:email => user.email).should == user
#      end

#      it 'should return user by login' do
#        User.find_for_database_authentication(:email => user.login).should == user
#      end
#      it 'should return nothing if not good login or email' do
#        User.find_for_database_authentication(:email => 'hello').should be_nil
#      end
#    end

#    describe "validation" do
#      it 'should not have 2 user with same provider/uid' do
#        u = Fabricate(:user)
#        u.user_tokens.create(:provider => 'twitter', :uid => '1234')
#        u.save

#        u = Fabricate(:user)
#        u.user_tokens.build(:provider => 'twitter', :uid => '1234')
#        u.should_not be_valid
#      end
#    end
#  end

