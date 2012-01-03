require 'spec_helper'

describe InviteCode do

  it { should be_mongoid_document }
  it { should be_timestamped_document }

  it { should have_field(:token).of_type(String) }
  it { should have_field(:invitation_sent_to).of_type(String) }
  it { should have_field(:invitation_sent_at).of_type(DateTime) }
  it { should have_field(:invitation_accepted_at).of_type(DateTime) }

  it { should validate_presence_of(:token) }
  it { should validate_uniqueness_of(:token) }

  it { should have_index_for(:token).with_options(:unique => true) }

  it "sets an invitation token before creation" do
    invite_code = InviteCode.create
    invite_code.token.should_not be_empty
  end

end

