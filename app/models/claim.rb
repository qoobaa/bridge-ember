class Claim < ActiveRecord::Base
  belongs_to :board

  validates :board_id,  presence: true
  validates :direction, presence: true, inclusion: Bridge::DIRECTIONS
  validates :tricks,    presence: true, inclusion: 0..13
  validate  :without_dummy, :accepted_inclusion, :rejected_inclusion, if: :playing?
  validate  :max_tricks, on: :create, if: :playing?

  def accept(direction)
    accepted << direction
    accepted.uniq!
    save
  end

  def reject(direction)
    rejected << direction
    rejected.uniq!
    save
  end

  def accepted?
    accept_condition_directions.all? { |direction| accepted.include?(direction) }
  end

  def rejected?
    rejected.any?
  end

  def resolved?
    accepted? or rejected?
  end

  def active?
    not resolved?
  end

  private

  def playing?
    !!board.try!(:play)
  end

  def accept_condition_directions
    play = board.play
    case direction
    when play.declarer then [play.lho, play.rho]
    when play.lho, play.rho then [play.declarer]
    end
  end

  def accepted_inclusion
    unless accepted.all? { |direction| accept_condition_directions.include?(direction) }
      errors.add(:accepted, :invalid)
    end
  end

  def rejected_inclusion
    unless rejected.all? { |direction| (Bridge::DIRECTIONS - [board.play.dummy]).include?(direction) }
      errors.add(:rejected, :invalid)
    end
  end

  def without_dummy
    errors.add(:direction, :invalid) if board.play.dummy == direction
  end

  def max_tricks
    errors.add(:tricks, :invalid) if tricks > 13 - board.play.tricks.count(&:complete?)
  end
end
