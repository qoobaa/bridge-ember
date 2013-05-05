class Api::ClaimsController < Api::ApplicationController
  before_action :require_user
  before_action :authorize_create, only: [:create]
  before_action :authorize_accept, only: [:accept]
  before_action :authorize_reject, only: [:reject]

  def create
    @claim = ClaimService.new.create(claim_params.merge(board: board))
    respond_with(claim, status: :created, location: nil)
  end

  def accept
    ClaimService.new(claim).accept(accept_params[:accepted])
    respond_with(claim)
  end

  def reject
    ClaimService.new(claim).reject(reject_params[:rejected])
    respond_with(claim)
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
