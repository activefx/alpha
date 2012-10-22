require 'spec_helper'

describe 'Api', :type => :api do

  context "header" do

    context "Content-Type" do
      before { get '/api/echo/show' }
      subject { last_response }

      it "should be set to json" do
        subject.header['Content-Type'].should =~ /#{Regexp.escape('application/json')}/
      end

      it "should be set to UTF-8" do
        subject.header['Content-Type'].should =~ /#{Regexp.escape('charset=utf-8')}/
      end
    end

  end

  context "errors" do

    context "#check_request_format!" do
      before { get '/api/echo/show.xml' }
      subject { last_response }
      it { subject.status.should eq 406 }
    end

    context "#check_request_action!" do
      before { post '/api/echo/show' }
      subject { last_response }
      it { subject.status.should eq 405 }
    end

    context "unimplemented endpoint" do
      before { get '/api/echo/index' }
      subject { last_response }
      it { subject.status.should eq 501 }
    end

    context "rescuing from" do

      context "#bad_request" do
        before { get '/api/echo/400' }
        subject { last_response }
        it { subject.status.should eq 400 }
        it { JSON.parse(subject.body)['error'].should eq Api::BAD_REQUEST }
      end

      context "#unauthorized" do
        before { get '/api/echo/401' }
        subject { last_response }
        it { subject.status.should eq 401 }
        it { JSON.parse(subject.body)['error'].should eq Api::UNAUTHORIZED }
      end

      context "#forbidden" do
        before { get '/api/echo/403' }
        subject { last_response }
        it { subject.status.should eq 403 }
        it { JSON.parse(subject.body)['error'].should eq Api::FORBIDDEN }
      end

      context "#access_denied" do
        before { get '/api/echo/access_denied' }
        subject { last_response }
        it { subject.status.should eq 403 }
        it { JSON.parse(subject.body)['error'].should eq Api::FORBIDDEN }
      end

      context "#not_found" do
        before { get '/api/echo/404' }
        subject { last_response }
        it { subject.status.should eq 404 }
        it { JSON.parse(subject.body)['error'].should eq Api::NOT_FOUND }
      end

      context "#rate_limit_exceeded" do
        before { get '/api/echo/rate_limit_exceeded' }
        subject { last_response }
        it { subject.status.should eq 403 }
        it { JSON.parse(subject.body)['error'].should =~ /exceeded/ }
      end

      context "#document_not_found" do
        before { get '/api/echo/document_not_found' }
        subject { last_response }
        it { subject.status.should eq 404 }
        it { JSON.parse(subject.body)['error'].should eq Api::NOT_FOUND }
      end

      context "#method_not_allowed" do
        before { get '/api/echo/405' }
        subject { last_response }
        it { subject.status.should eq 405 }
        it { JSON.parse(subject.body)['error'].should eq Api::METHOD_NOT_ALLOWED }
      end

      context "#not_acceptable" do
        before { get '/api/echo/406' }
        subject { last_response }
        it { subject.status.should eq 406 }
        it { JSON.parse(subject.body)['error'].should eq Api::NOT_ACCEPTABLE }
      end

      context "#conflict" do
        before { get '/api/echo/409' }
        subject { last_response }
        it { subject.status.should eq 409 }
        it { JSON.parse(subject.body)['error'].should eq Api::CONFLICT }
      end

      context "#unprocessable_entity" do
        before { get '/api/echo/422'}
        subject { last_response }
        it { subject.status.should eq 422 }
        it { JSON.parse(subject.body)['error'].should eq Api::UNPROCESSABLE_ENTITY }
      end

      context "#not_implemented" do
        before { get '/api/echo/501' }
        subject { last_response }
        it { subject.status.should eq 501 }
        it { JSON.parse(subject.body)['error'].should eq Api::NOT_IMPLEMENTED }
      end

      context "#service_unavailable" do
        before { get '/api/echo/503' }
        subject { last_response }
        it { subject.status.should eq 503 }
        it { JSON.parse(subject.body)['error'].should eq Api::SERVICE_UNAVAILABLE }
      end

      context "#internal_service_error" do
        before { get '/api/echo/500' }
        subject { last_response }
        it { subject.status.should eq 500 }
        it { JSON.parse(subject.body)['error'].should eq Api::INTERNAL_SERVER_ERROR }
      end

    end

  end

  context "rate limiting" do
    let(:user) { create(:user) }
    let(:api_key) { user.create_api_key.token }

    context "records first request" do
      before do
        header 'X-API-KEY', api_key
        get '/api/echo/authenticate'
      end
      subject { last_response }
      it {
        subject.header['X-Monthly-Rate-Limit-Remaining'].
        should eq Api::V1::BaseController::MONTHLY_API_RATE_LIMIT - 1
      }
      it {
        subject.header['X-Daily-Rate-Limit-Remaining'].
        should eq Api::V1::BaseController::DAILY_API_RATE_LIMIT - 1
      }
      it {
        subject.header['X-Hourly-Rate-Limit-Remaining'].
        should eq Api::V1::BaseController::HOURLY_API_RATE_LIMIT - 1
      }
    end

    context "records subsequent requests" do
      let(:api_requests) { Api::V1::BaseController::HOURLY_API_RATE_LIMIT - 10 }
      before do
        Api::V1::BaseController.any_instance.stub :api_calls => api_requests
        header 'X-API-KEY', api_key
        get '/api/echo/authenticate'
      end
      subject { last_response }
      it {
        subject.header['X-Monthly-Rate-Limit-Remaining'].
        should eq Api::V1::BaseController::MONTHLY_API_RATE_LIMIT - api_requests
      }
      it {
        subject.header['X-Daily-Rate-Limit-Remaining'].
        should eq Api::V1::BaseController::DAILY_API_RATE_LIMIT - api_requests
      }
      it {
        subject.header['X-Hourly-Rate-Limit-Remaining'].
        should eq Api::V1::BaseController::HOURLY_API_RATE_LIMIT - api_requests
      }
    end

    context "prevents rate limit overages" do
      it {
        Api::V1::BaseController.any_instance.
          stub :api_calls => Api::V1::BaseController::HOURLY_API_RATE_LIMIT + 1
        header 'X-Api-Key', api_key
        get '/api/echo/authenticate'
        last_response.status.should eq 403
      }
      it {
        Api::V1::BaseController.any_instance.
          stub :api_calls => Api::V1::BaseController::DAILY_API_RATE_LIMIT + 1
        header 'X-Api-Key', api_key
        get '/api/echo/authenticate'
        last_response.status.should eq 403
      }
      it {
        Api::V1::BaseController.any_instance.
          stub :api_calls => Api::V1::BaseController::MONTHLY_API_RATE_LIMIT + 1
        header 'X-Api-Key', api_key
        get '/api/echo/authenticate'
        last_response.status.should eq 403
      }
    end

  end


end
