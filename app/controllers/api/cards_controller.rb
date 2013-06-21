class Api::CardsController < Api::ApplicationController
  before_action :require_user, :authorize

  def create
    @card = board.cards.create(card_params)

    if @card.persisted?
      Event::CardCreated.new(@card)
      Event::DummyRevealed.new(table) if board.cards.count == 1 # First lead

      claim = board.claims.last
      if claim.present? and claim.active? # Reject claim by playing card
        ClaimService.new(claim).reject(board.user_direction(current_user))
      end
    end

    if board.play.finished?
      board.update!(result: board.score.result)
      table.create_board!
      Event::BoardCreated.new(table)
    end
    respond_with(@card, status: :created, location: nil)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def table
    @table ||= board.table
  end

  def card_params
    params.require(:card).permit(:content)
  end

  def authorize
    head(:unauthorized) unless CardAuthorizer.new(current_user).create_allowed?(board)
  end
end
