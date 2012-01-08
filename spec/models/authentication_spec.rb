require 'spec_helper'

describe Authentication do

  it { should be_mongoid_document }
  it { should be_timestamped_document }
  it { should belong_to(:user) }

  it { should have_field(:provider).of_type(String) }
  it { should have_field(:uid).of_type(String) }
  it { should have_field(:token).of_type(String) }
  it { should have_field(:secret).of_type(String) }
  it { should have_field(:expires_at).of_type(Integer) }
  it { should have_field(:expires).of_type(Boolean) }
  it { should have_field(:refresh_token).of_type(String) }
  it { should have_field(:omniauth).of_type(Hash) }

  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }

  it { should have_index_for([[:provider, 1], [:uid, 1]]) }

end

