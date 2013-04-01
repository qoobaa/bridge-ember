class Api::CardsController < Api::ApplicationController
  # TODO: add authorization
  def create
    @card = Card.create(card_params) do |card|
      card.board = board
    end

    respond_with(@card, status: :created)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def card_params
    params.require(:card).permit(:content)
  end
end
