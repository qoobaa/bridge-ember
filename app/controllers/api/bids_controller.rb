class Api::BidsController < Api::ApplicationController
  # TODO: add authorization
  def create
    @bid = Bid.create(bid_params) do |bid|
      bid.board = board
    end

    respond_with(@bid, status: :created)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def bid_params
    params.require(:bid).permit(:content)
  end
end
