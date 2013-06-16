class Api::CardsController < Api::ApplicationController
  before_action :require_user, :authorize

  def create
    @card = board.cards.create(card_params)

    if @card.persisted?
      # publish card create to table (data: card)

      if board.cards.count == 1 # First lead
        # show hand of dummy to table (data: cards of dummy player)
      end

      if (claim = board.claims.last) && claim.active? # Reject claim by playing card
        ClaimService.new(claim).reject(board.user_direction(current_user))
      end
    end

    if board.play.finished?
      board.update!(result: board.score.result)
      board.table.create_board!
      # publish board update to table (data: board)
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
