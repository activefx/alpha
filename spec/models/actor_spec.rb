require 'spec_helper'

describe Actor do

  it { should be_mongoid_document }
  it { should be_timestamped_document }

  context "model" do

    subject { Actor.new }
    it { should_not allow_mass_assignment_of(:id => 1) }

  end

end

