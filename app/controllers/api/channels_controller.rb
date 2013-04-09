class Api::ChannelsController < Api::ApplicationController
  def create
    @channel = Channel.find_or_create_by(name: channel_params[:name])
    @channel.table_id = channel_params[:table_id]
    @channel.user_id = current_user.try(:id)
    @channel.connect!

    head :created
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :table_id)
  end
end
