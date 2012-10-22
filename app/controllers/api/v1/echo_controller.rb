class Api::V1::EchoController < Api::V1::BaseController

  skip_before_filter :authenticate_api_user!, :except => [ :authenticate ]
  skip_before_filter :rate_limit_api_requests!, :except => [ :authenticate ]

  def show
    render :status => :ok, :json => {}
  end

  def create
    render :status => :created, :json => {}
  end

  def update
    render :status => :no_content, :json => {}
  end

  def destroy
    render :status => :no_content, :json => {}
  end

  def authenticate
    render :status => :ok, :json => {}
  end

  def status
    case params[:status_code].to_s
    when '400' then raise Api::BadRequest
    when '401' then raise Api::Unauthorized
    when '403' then raise Api::Forbidden
    when '404' then raise Api::NotFound
    when '405' then raise Api::MethodNotAllowed
    when '406' then raise Api::NotAcceptable
    when '409' then raise Api::Conflict
    when '422' then raise Api::UnprocessableEntity
    when '501' then raise Api::NotImplemented
    when '503' then raise Api::ServiceUnavailable
    when 'access_denied'
      raise CanCan::AccessDenied
    when 'document_not_found'
      raise Mongoid::Errors::DocumentNotFound.new(User,{})
    when 'rate_limit_exceeded'
      raise Api::RateLimitExceeded,
      'You have exceeded your alloted number of API calls.'
    else raise Api::InternalServerError
    end
  end



end
