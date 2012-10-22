require 'spec_helper'

describe '/api/v1/echo', :type => :api do

  context "GET show" do
    before { get '/api/echo/show' }
    subject { last_response.status }
    it { should eq 200 }
  end

  context "POST create" do
    before { post '/api/echo/create' }
    subject { last_response.status }
    it { should eq 201 }
  end

  context "PUT update" do
    before { put '/api/echo/update' }
    subject { last_response.status }
    it { should eq 204 }
  end

  context "DELETE destroy" do
    before { delete '/api/echo/destroy' }
    subject { last_response.status }
    it { should eq 204 }
  end

  context "authentication" do

    context "without valid credentials" do
      before { get '/api/echo/authenticate' }
      subject { last_response.status }
      it { should eq 401 }
    end

    context "with invalid token" do
      before do
        header 'X-Auth-Token', 'not-a-valid-token'
        get '/api/echo/authenticate'
      end
      subject { last_response.status }
      it { should eq 401 }
    end

    context "with token" do
      let(:user) { create(:user) }
      let(:token) do
        user.ensure_authentication_token_for_api!
        user.authentication_token
      end

      context "with token parameter" do
        before do
          get '/api/echo/authenticate?auth_token=' + token
        end
        subject { last_response.status }
        it { should eq 200 }
      end

      context "with token header" do
        before do
          header 'X-Auth-Token', token
          get '/api/echo/authenticate'
        end
        subject { last_response.status }
        it { should eq 200 }
      end
    end

    context "with invalid api key" do
      before do
        header 'X-Api-Key', 'not-a-valid-key'
        get '/api/echo/authenticate'
      end
      subject { last_response.status }
      it { should eq 401 }
    end

    context "with api key" do
      let(:user) { create(:user) }
      let(:api_key) { user.create_api_key.token }

      context "parameter" do
        before do
          get '/api/echo/authenticate?api_key=' + api_key
        end
        subject { last_response.status }
        it { should eq 200 }
      end

      context "header" do
        before do
          header 'X-Api-Key', api_key
          get '/api/echo/authenticate'
        end
        subject { last_response.status }
        it { should eq 200 }
      end
    end

  end

end
