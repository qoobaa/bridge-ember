class Claim < ActiveRecord::Base
  belongs_to :board

  validates :board_id,  presence: true
  validates :direction, presence: true, inclusion: Bridge::DIRECTIONS
  validates :tricks,    presence: true, inclusion: 0..13
  validate  :without_dummy, :accepted_directions_inclusion, :rejected_directions_inclusion
  validate  :max_tricks, on: :create

  def accept(direction)
    accepted_directions << direction
    accepted_directions.uniq!
    save
  end

  def reject(direction)
    rejected_directions << direction
    rejected_directions.uniq!
    save
  end

  def accepted?
    accept_condition_directions.all? { |direction| accepted_directions.include?(direction) }
  end

  def rejected?
    rejected_directions.any?
  end

  def resolved?
    accepted? or rejected?
  end

  def active?
    not resolved?
  end

  private

  def accept_condition_directions
    play = board.play
    case direction
    when play.declarer then [play.lho, play.rho]
    when play.lho, play.rho then [play.declarer]
    end
  end

  def accepted_directions_inclusion
    return unless board.try!(:play)
    unless accepted_directions.all? { |direction| accept_condition_directions.include?(direction) }
      errors.add(:accepted_directions, :invalid)
    end
  end

  def rejected_directions_inclusion
    return unless board.try!(:play)
    unless rejected_directions.all? { |direction| (Bridge::DIRECTIONS - [board.play.dummy]).include?(direction) }
      errors.add(:rejected_directions, :invalid)
    end
  end

  def without_dummy
    if play = board.try!(:play)
      errors.add(:direction, :invalid) if play.dummy == direction
    end
  end

  def max_tricks
    if play = board.try!(:play)
      errors.add(:tricks, :invalid) if tricks > 13 - play.tricks.count(&:complete?)
    end
  end
end
