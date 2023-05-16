class Api::V1::AuthController < Api::V1::ApplicationController
  def login
    Users::Login.new.call(login_params.to_h) do |on|
      on.success { |token_payload| render json: token_payload, status: :ok }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def request_password_recovery
    Users::GenerateRecoverToken.new.call(login_params.to_h) do |on|
      on.success { |success_msg| render json: { message: success_msg } }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def reset_password
    Users::ResetPassword.new.call(reset_password_params.to_h) do |on|
      on.success { |success_msg| render json: { message: success_msg } }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def logout
    Users::Logout.new.call(login_params.to_h) do |on|
      on.success { |user| render_serializable(user, UserSerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def reset_password_params
    params.permit(
      :password,
      :uuid,
      :recover_token
    )
  end

  def login_params
    params.permit(
      :email,
      :password
    )
  end
end