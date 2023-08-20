class Api::V1::CommunityGroupsController < Api::V1::ApplicationController
  before_action :authenticate
  before_action :find_community_group, only: %i(destroy show)

  def create
    CommunityGroups::Create.new.call(community_group_params.to_h) do |on|
      on.success { |c_group| render_serializable(c_group, CommunityGroupSerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  def index
    render_serializable(@current_user.community_groups, CommunityGroupSerializer, :ok)
  end

  def show
    render_serializable(@community_group, CommunityGroupSerializer, :ok)
  end

  def destroy
    if @community_group.destroy
      render_serializable(@community_group, CommunityGroupSerializer, :ok)
    else
      render json: { errors: 'Erro ao deletar' }, status: :unprocessable_entity
    end
  end

  def update
    CommunityGroups::Update.new.call(
      input: community_group_params.to_h,
      id: params[:id],
      current_user: @current_user
    ) do |on|
      on.success { |c_group| render_serializable(c_group, CommunityGroupSerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def find_community_group
    @community_group = @current_user.community_groups.find(params[:id])
  end

  def community_group_params
    params.require(:community_group).permit(
      :name,
      :description,
      roles: [],
    ).merge(user_id: @current_user.id)
  end

end
