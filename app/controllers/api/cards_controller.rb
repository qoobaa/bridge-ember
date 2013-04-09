class Api::CardsController < Api::ApplicationController
  before_action :require_user, :check_direction

  def create
    @card = board.cards.create(card_params)

    if @card.persisted?
      if board.cards.count == 1 # First lead
        table.user_n_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_n, scope_name: :current_user)
        table.user_e_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_e, scope_name: :current_user)
        table.user_s_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_s, scope_name: :current_user)
        table.user_w_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_w, scope_name: :current_user)
      else
        table.publish(event: "cards/create", data: CardSerializer.new(@card))
      end
    end

    if board.play.finished?
      board.update!(result: board.score.result)
      board.table.create_board!

      table.user_n_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_n, scope_name: :current_user)
      table.user_e_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_e, scope_name: :current_user)
      table.user_s_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_s, scope_name: :current_user)
      table.user_w_publish event: "table/update", data: TableSerializer.new(table, scope: table.user_w, scope_name: :current_user)
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

  def check_direction
    play = board.play
    # Declarer can play dummy cards
    if play.next_direction == play.dummy ? play.declarer != board.user_direction(current_user) : play.next_direction != board.user_direction(current_user)
      head(:unauthorized)
    end
  end
end
