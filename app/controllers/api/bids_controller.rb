class Api::BidsController < Api::ApplicationController
  before_action :require_user, :check_direction

  def create
    @bid = Bid.create(bid_params.merge(board: board))
    board.update!(contract: board.auction.contract) if board.auction.finished?
    # TODO: publish to a tables/:table_id channel
    redis_publish(event: "tables/#{board.table_id}/bids/create", data: BidSerializer.new(@bid)) if @bid.persisted?
    respond_with(@bid, status: :created, location: nil)
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
