class BidAuthorizer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_allowed?(board)
    board.contract.nil? and
    board.auction.next_direction == board.user_direction(user)
  end
end
