class Api::BidsController < Api::ApplicationController
  before_action :check_direction

  # TODO: add authorization
  def create
    @bid = Bid.create(bid_params.merge(board: board))
    board.update!(contract: board.auction.contract) if board.auction.finished?

    respond_with(@bid, status: :created)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def bid_params
    params.require(:bid).permit(:content)
  end

  def check_direction
    direction = board.dealer
    board.bids.count.times { direction = Bridge.next_direction(direction) }
    # head(:unauthorized) if direction != # user direction
  end
end
