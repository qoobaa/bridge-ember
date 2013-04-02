class Api::ChannelsController < Api::ApplicationController
  def create
    @channel = Channel.find_or_create_by(channel_params)
    @channel.user_id = current_user.try(:id)
    @channel.connect!

    head :created
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end
end
