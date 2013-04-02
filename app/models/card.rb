class Card < ActiveRecord::Base
  belongs_to :board

  validates :board_id, presence: true
  validates :content,  presence: true, inclusion: {in: Bridge::DECK, message: :invalid}, uniqueness: {scope: :board_id}
  validate :allowed_in_board

  def card
    Bridge::Card.new(content) if content
  rescue ArgumentError # do not raise on invalid card
  end

  private

  def allowed_in_board
    if board && card
      errors.add(:content, :not_allowed) unless board.play.card_allowed?(card.to_s)
    end
  end
end
