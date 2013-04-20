class CardAuthorizer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_allowed?(board)
    return false if board.complete?
    play = board.play
    if play.next_direction == play.dummy # Declarer plays dummy cards
      play.declarer == board.user_direction(user)
    else
      play.next_direction == board.user_direction(user)
    end
  end
end
