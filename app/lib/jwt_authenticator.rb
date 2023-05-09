class JwtAuthenticator
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def initialize(headers = {})
    @headers = headers
  end

  def authenticate!
    user
  end

  private

  attr_reader :headers

  def user
    # debugger
    @user ||= User.find(decoded_auth_token['user_id']) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JWT.decode(http_auth_header, SECRET_KEY).first
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
