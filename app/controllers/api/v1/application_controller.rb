class Api::V1::ApplicationController < ActionController::API
  protected

  def render_serializable(object, serializer, status = :ok)
    render json: serializer.new(object).serializable_hash, status: status
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    @current_user = JwtAuthenticator.new(request.headers['Authorization']).authenticate!
    @current_user
  end

  def render_unauthorized
    render json: { error: 'Bad credentials' }, status: 401
  end
end
