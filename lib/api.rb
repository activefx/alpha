require 'api/controller_setup'

module Api

  class Error < StandardError

    def log_output
      message + "\n " + backtrace.join("\n ")
    end

  end

  # 400 Bad Request - Used as a general catchall for bad requests. For example, if
  # there is a validation error on a model, a service could respond with a 400 error
  # and a response body that indicates what validations failed.
  class BadRequest < Error; end
  BAD_REQUEST = 'There was a problem with your request.'

  # 401 Unauthorized - Used when a resource is requested that requires authentication.
  class Unauthorized < Error; end
  UNAUTHORIZED = 'The requested resource requires valid authentication credentials.'

  # 403 Forbidden - Used when a resource is requested that an authenticated user
  # does not have permission to access.
  class Forbidden < Error; end
  class RateLimitExceeded < Error; end
  FORBIDDEN = 'You do not have permission to complete that request.'

  # 404 Not Found - Used when requesting a resource that the server doesn’t know about.
  class NotFound < Error; end
  NOT_FOUND = 'The requested resource was not found.'

  # 405 Method Not Allowed - Used when a client attempts to perform an operation
  # on a resource that it doesn’t support (for example, performing a GET on a
  # resource that requires a POST).
  class MethodNotAllowed < Error; end
  METHOD_NOT_ALLOWED = 'That operation cannot be performed on this resource.'

  # 406 Not Acceptable - Used when the request is not acceptable according to the
  # Accept headers in the request (for example, if the service uses the Accept headers
  # to indicate a requested API version and a client requests a version that is no longer
  # supported).
  class NotAcceptable < Error; end
  NOT_ACCEPTABLE = 'The request was made in a manner that is not acceptable.'

  # 409 Conflict - Used when a client attempts to update a resource that has an edit
  # conflict. For example, say that two clients request a blog post at the same time.
  # One client makes changes and submits the post. The second client also makes
  # changes and submits the post, but the server has found that the second client’s
  # copy is now out of date. The second client should request the resource again and
  # inform the user of the now-updated post, allowing the user to make changes.
  class Conflict < Error; end
  CONFLICT = 'The changes to the resource conflict with another set of changes.'

  # 422 Unprocessable Entity - Used when the request was well-formed but was unable
  # to be followed due to semantic errors. In general, this error occurs due to
  # errors caused by validation failures.
  class UnprocessableEntity < Error; end
  UNPROCESSABLE_ENTITY = 'The attributes passed to the resouce were not valid.'

  # 500 Internal Server Error - The server encountered an unexpected condition which
  # prevented it from fulfilling the request.
  class InternalServerError < Error; end
  INTERNAL_SERVER_ERROR = 'There was a problem fulfilling your request.'

  # 501 Not Implemented - The server does not support the facility required.
  class NotImplemented < Error; end
  NOT_IMPLEMENTED = 'The API does not support that request.'

  # 503 Service Uunavailable - Used when the service is temporarily unavailable,
  # generally in the event that the rate limit, if applicable, has been exceeded.
  class ServiceUnavailable < Error; end
  SERVICE_UNAVAILABLE = 'The API is temporarily unavailable.'


end
