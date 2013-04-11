class Api::ClaimsController < Api::ApplicationController
  before_action :require_user, :check_direction
  before_action :check_board, only: [:create]

  def create
    @claim = board.claims.create(claim_params)
    # board.table.users.each do |user|
    #   user.publish event: "table/update", data: TableSerializer.new(board.table, scope: user, scope_name: :current_user)
    # end
    respond_with(@claim, status: :created, location: nil)
  end

  def accept
    @claim = board.claims.active.find(params[:id])
  end

  def reject
    @claim = board.claims.active.find(params[:id])
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def claim_params
    params.require(:claim).permit(:direction, :tricks)
  end

  def check_direction
    head(:unauthorized) if claim_params[:direction] != board.user_direction(current_user)
  end

  def check_board
    if board.claims.active.exists? || board.play.nil?
      head(:unauthorized)
    end
  end
end
