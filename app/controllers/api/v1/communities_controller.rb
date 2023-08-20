class Api::V1::CommunitiesController < Api::V1::ApplicationController
  before_action :authenticate

  def create
    Community::Create.new.call(community_params.to_h) do |on|
      on.success { |community| render_serializable(community, CommunitySerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def update
    Community::Update.new.call(
      current_user: @current_user,
      input: community_params.to_h,
      id: params[:id]
    ) do |on|
      on.success { |community| render_serializable(community, CommunitySerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def show
    render_serializable(@current_user.communities.find(params[:id]), CommunitySerializer, :ok)
  end

  def index
    render_serializable(@current_user.communities, CommunitySerializer, :ok)
  end

  private

  def community_params
    params.require(:community).permit(
      :name,
      :description,
      :primary_color,
      :secondary_color
    ).merge(user_id: @current_user.id)
  end
end
