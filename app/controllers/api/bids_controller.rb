class Api::BidsController < Api::ApplicationController
  before_action :require_user, :authorize

  def create
    @bid = board.bids.create(bid_params)
    board.update!(contract: board.auction.contract) if board.auction.finished?
    @board.table.publish(event: "bids/create", data: BidSerializer.new(@bid)) if @bid.persisted?
    respond_with(@bid, status: :created, location: nil)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def bid_params
    params.require(:bid).permit(:content)
  end

  def authorize
    head(:unauthorized) if board.auction.next_direction != board.user_direction(current_user)
  end
end
