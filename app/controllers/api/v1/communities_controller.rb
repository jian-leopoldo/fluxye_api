class Api::V1::CommunitiesController < Api::V1::ApplicationController
  before_action :authenticate
  before_action :find_community_group

  def create
    Community::Create.new.call(community_params.to_h) do |on|
      on.success { |community| render_serializable(community, CommunitySerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def update
    Community::Update.new.call(
      current_user: @current_user,
      community_group_id: params[:community_group_id],
      input: community_params.to_h,
      id: params[:id]
    ) do |on|
      on.success { |community| render_serializable(community, CommunitySerializer, :ok) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def find_community_group
    @community_group = @current_user.community_groups.find(params[:community_group_id])
  end

  def community_params
    params.require(:community).permit(
      :name,
      :description,
    ).merge(community_group_id: @community_group.id)
  end
end
