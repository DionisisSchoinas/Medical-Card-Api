# app/auth/authorize_api_request.rb
class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    # Ensure token isn't a QR only token
    if decoded_auth_token[:is_qr].nil?
      # check if user is in the database
      # memorize user object
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    else
      raise(ExceptionHandler::InvalidToken, ("#{Message.invalid_token}"))
    end
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(ExceptionHandler::InvalidToken, ("#{Message.invalid_token} #{e.message}"))
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `AuthorizationToken` header
  def http_auth_header
    if headers['AuthorizationToken'].present?
      return headers['AuthorizationToken'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
