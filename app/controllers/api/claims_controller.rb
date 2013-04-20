class Api::ClaimsController < Api::ApplicationController
  before_action :require_user
  before_action :authorize_create, only: [:create]
  before_action :authorize_accept, only: [:accept]
  before_action :authorize_reject, only: [:reject]

  def create
    @claim = board.claims.create(claim_params)
    if @claim.persisted?
      board.table.users.each do |user|
        user.publish event: "claim/update", data: ClaimSerializer.new(@claim)
        # FIXME: find better way of partial serialization
        payload = {board: {@claim.direction.downcase.to_sym => board.deal[@claim.direction].map(&:to_s)}}
        user.publish event: "board/update", data: payload
      end
    end
    respond_with(@claim, status: :created, location: nil)
  end

  def accept
    if claim.accept(accept_params[:accepted])
      board.update!(result: board.score.result) if claim.accepted?

      board.table.create_board!

      board.table.users.each do |user|
        user.publish event: "claim/update", data: ClaimSerializer.new(@claim)
        user.publish event: "board/update", data: {board: {result: board.result}} if claim.accepted?
        # New board
        user.publish event: "table/update", data: TableSerializer.new(board.table, scope: user, scope_name: :current_user)
      end
    end
    respond_with(@claim)
  end

  def reject
    if claim.reject(reject_params[:rejected])
      board.table.users.each do |user|
        user.publish event: "claim/update", data: ClaimSerializer.new(@claim)
      end
    end
    respond_with(@claim)
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def claim
    @claim ||= board.claims.find(params[:id])
  end

  def claim_params
    params.require(:claim).permit(:direction, :tricks)
  end

  def accept_params
    params.require(:claim).permit(:accepted)
  end

  def reject_params
    params.require(:claim).permit(:rejected)
  end

  def authorize_create
    head(:unauthorized) unless ClaimAuthorizer.new(current_user).create_allowed?(board, claim_params)
  end

  def authorize_accept
    head(:unauthorized) unless ClaimAuthorizer.new(current_user).accept_allowed?(board, claim, accept_params)
  end

  def authorize_reject
    head(:unauthorized) unless ClaimAuthorizer.new(current_user).reject_allowed?(board, claim, reject_params)
  end
end
