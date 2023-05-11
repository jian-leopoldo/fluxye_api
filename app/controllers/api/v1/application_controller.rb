class Api::V1::ApplicationController < ActionController::API
  protected

  def render_serializable(object, serializer, status = :ok)
    render json: serializer.new(object).serializable_hash, status: status
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { error: 'Bad credentials' }, status: 401
  end
end
