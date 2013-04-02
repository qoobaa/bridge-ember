class Api::CardsController < Api::ApplicationController
  before_action :check_direction

  # TODO: add authorization
  def create
    @card = Card.create(card_params.merge(board: board))

    respond_with(@card, status: :created)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def card_params
    params.require(:card).permit(:content)
  end

  def check_direction
    # head(:unauthorized) if board.play.next_direction == user direction
  end
end
