class Api::V1:UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
  end

  def create
    result = User::CreateUser.new.call(params)
    if result.success?
      render_serializable(result.value!, UserSerializer, status: :created)
    else
      render json: { errors: result.failure }, status: :unprocessable_entity
    end
  end

  def show
    render_serializable(@user, UserSerializer, status: :ok)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
