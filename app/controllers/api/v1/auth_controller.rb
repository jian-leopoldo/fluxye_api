class Api::V1::AuthController < Api::V1::ApplicationController
  def login
    Users::Login.new.call(login_params.to_h) do |on|
      on.success { |token_payload| render json: token_payload, status: :ok }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def recover_password
    Users::RecoverPassword.new.call(user_params.to_h) do |on|
      on.success { |user| render_serializable(user, UserSerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end


  def logout
    Users::Logout.new.call(user_params.to_h) do |on|
      on.success { |user| render_serializable(user, UserSerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def login_params
    params.permit(
      :email,
      :password
    )
  end
end