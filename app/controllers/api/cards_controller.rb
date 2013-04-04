class Api::CardsController < Api::ApplicationController
  before_action :require_user, :check_direction

  def create
    @card = Card.create(card_params.merge(board: board))

    respond_with(@card, status: :created, location: nil)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def card_params
    params.require(:card).permit(:content)
  end

  def check_direction
    head(:unauthorized) if board.play.next_direction != board.user_direction(current_user)
  end
end
