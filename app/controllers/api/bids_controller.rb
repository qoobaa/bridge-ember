class Api::BidsController < Api::ApplicationController
  before_action :check_direction
  # TODO: add authorization
  # TODO: decide if additional validation should be moved to model or some other class
  def create
    @bid = Bid.new(bid_params.merge(board: board))
    if @bid.valid?
      @bid.errors.add(:content, :not_allowed) unless Bridge::Auction.new(board.bids.map(&:content)).bid_allowed?(@bid.content)
    end
    @bid.save! if @bid.errors.none?

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
