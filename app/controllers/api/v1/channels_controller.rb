class Api::V1::ChannelsController < Api::V1::ApplicationController
  def create
    Channel::Create.new.call(community_params.to_h) do |on|
      on.success { |channel| render_serializable(channel, ChannelSerializer, :created) }
      on.failure { |errors| render json: { errors: errors }, status: :unprocessable_entity }
    end
  end

  private

  def community_params
    params.require(:channel).permit(
      :name,
      :description,
    ).merge(community_id: @community.id)
  end
end
