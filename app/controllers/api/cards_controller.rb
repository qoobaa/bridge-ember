class Api::CardsController < Api::ApplicationController
  before_action :require_user, :check_direction

  def create
    @card = Card.create(card_params.merge(board: board))
    @board.table.publish(event: "cards/create", data: CardSerializer.new(@card)) if @card.persisted?
    if board.play.finished?
      board.update!(result: board.score.result)
      board.table.create_board!
      # TODO: notify about new board
    end
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
    play = board.play
    # Declarer can play dummy cards
    if play.next_direction == play.dummy ? play.declarer != board.user_direction(current_user) : play.next_direction != board.user_direction(current_user)
      head(:unauthorized)
    end
  end
end
