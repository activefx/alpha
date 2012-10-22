require 'spec_helper'

describe '/api/users', :type => :api do

  context "POST show" do

    context "with valid parameters" do
      before do
        post '/api/users', :user => {
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end
      subject { last_response }
      it { subject.status.should eq 201 }
      it { JSON.parse(subject.body)['auth_token'].should_not be_nil }
    end

    context "with invalid parameters" do
      before do
        post '/api/users', :user => {
          email: 'user',
          password: 'password',
          password_confirmation: 'password'
        }
      end
      subject { last_response }
      let(:error) { {"error"=>{"email"=>["is invalid"]}}.to_json }
      it { subject.status.should eq 422 }
      it { subject.body.should eq error }
    end

    context "with missing parameters" do
      before do
        post '/api/users', :user => {
          password: 'password',
          password_confirmation: 'password'
        }
      end
      subject { last_response }
      let(:error) { {"error"=>{"email"=>["can't be blank"]}}.to_json }
      it { subject.status.should eq 422 }
      it { subject.body.should eq error }
    end

  end

end
