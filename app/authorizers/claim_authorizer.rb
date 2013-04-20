class ClaimAuthorizer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_allowed?(board, params)
    !board.claims.last.try!(:active?) and
    board.play.present? and
    !board.complete? and
    params[:direction] == board.user_direction(user)
  end

  def accept_allowed?(board, claim, params)
    claim.active? and
    params[:accepted] == board.user_direction(user)
  end

  def reject_allowed?(board, claim, params)
    claim.active? and
    params[:accepted] == board.user_direction(user)
  end
end
