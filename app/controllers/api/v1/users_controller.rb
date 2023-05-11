class Api::V1::UsersController < Api::V1::ApplicationController
  def index
    Users::ListAll.new.call(params[:q]) do |on|
      on.success { |users| render_serializable(users, UserSerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def update
    Users::Update.new.call(input: user_params.to_h, id: params[:id]) do |on|
      on.success { |user| render_serializable(user, UserSerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def create
    Users::Create.new.call(user_params.to_h) do |on|
      on.success { |user| render_serializable(user, UserSerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def show
    Users::Show.new.call(id: params[:id]) do |on|
      on.success { |user| render_serializable(user, UserSerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def query_params
    params.permit(:roles)
  end

  def user_params
    params.require(:user).permit(
      :email,
      :name,
      :phone,
      :password,
      :password_confirmation
    )
  end
end
