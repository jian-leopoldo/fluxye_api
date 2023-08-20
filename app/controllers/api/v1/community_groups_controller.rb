class Api::V1::CommunityGroupsController < Api::V1::ApplicationController
  before_action :authenticate

  def create
    CommunityGroups::Create.new.call(community_group_params.to_h) do |on|
      on.success { |c_group| render_serializable(c_group, CommunityGroupSerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def community_group_params
    params.require(:community_group).permit(
      :name,
      :description,
      roles: [],
    ).merge(user_id: @current_user.id)
  end

end
