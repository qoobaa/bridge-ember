class Api::BidsController < Api::ApplicationController
  before_action :require_user, :check_direction

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
    head(:unauthorized) if board.auction.next_direction != board.user_direction(current_user)
  end
end
