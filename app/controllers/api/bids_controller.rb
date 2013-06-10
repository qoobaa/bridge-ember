class Api::BidsController < Api::ApplicationController
  before_action :require_user, :authorize

  def create
    @bid = board.bids.create(bid_params)
    board.update!(contract: board.auction.contract) if board.auction.finished?
    board.table.users.each do |user|
      redis_publish "tables/#{table.id}/#{table.user_direction(user).downcase}", event: "bids/create", data: BidSerializer.new(@bid, scope: user, scope_name: :current_user)
      redis_publish "tables/#{table.id}/guest", event: "bids/create", data: BidSerializer.new(@bid)
    end

    respond_with(@bid, status: :created, location: nil)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def bid_params
    params.require(:bid).permit(:content, :alert)
  end

  def authorize
    head(:unauthorized) unless BidAuthorizer.new(current_user).create_allowed?(board)
  end
end
