class Claim < ActiveRecord::Base
  belongs_to :board

  validates :board_id,  presence: true
  validates :direction, presence: true, inclusion: Bridge::DIRECTIONS
  validates :tricks,    presence: true, inclusion: 0..13
  validates :state,     inclusion: {in: ["accepted", "rejected"], allow_nil: true}
  validate  :without_dummy

  scope :active, -> { where(state: nil) }

  def accepted?
    accept_condition_directions.all? { |direction| accepted_directions.include?(direction) }
  end

  def rejected?
    rejected_directions.any?
  end

  private

  def accept_condition_directions
    play = board.play
    case direction
    when play.declarer then [play.lho, play.rho]
    when play.lho, play.rho then [play.declarer]
    end
  end

  def without_dummy
    if play = board.try!(:play)
      errors.add(:direction, :invalid) if play.dummy == direction
    end
  end
end
