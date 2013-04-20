class Api::CardsController < Api::ApplicationController
  before_action :require_user, :authorize

  def create
    @card = board.cards.create(card_params)

    if @card.persisted?
      if board.cards.count == 1 # First lead
        table.users.each do |user|
          user.publish event: "table/update", data: TableSerializer.new(table, scope: user, scope_name: :current_user)
        end
      else
        table.publish(event: "cards/create", data: CardSerializer.new(@card))
      end

      if (claim = board.claims.last) && claim.active? # Reject claim by playing card
        claim.reject(board.user_direction(current_user))
        board.table.users.each do |user|
          user.publish event: "claim/update", data: ClaimSerializer.new(claim)
        end
      end
    end

    if board.play.finished?
      board.update!(result: board.score.result)
      board.table.create_board!

      table.users.each do |user|
        user.publish event: "table/update", data: TableSerializer.new(table, scope: user, scope_name: :current_user)
      end
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
