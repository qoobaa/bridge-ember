class Api::BidsController < Api::ApplicationController
  before_action :require_user, :authorize

  def create
    @bid = board.bids.create(bid_params)
    board.update!(contract: board.auction.contract) if board.auction.finished?
    # publish bids create to table (data: bid, direction)
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
