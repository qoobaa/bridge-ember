class Bid < ActiveRecord::Base
  belongs_to :board

  validates :board_id, presence: true
  validates :content,  presence: true, inclusion: {in: Bridge::BIDS, message: :invalid}
  validate :allowed_in_board

  def bid
    Bridge::Bid.new(content) if content
  rescue ArgumentError # do not raise on invalid bids
  end

  private

  def allowed_in_board
    if board && bid
      errors.add(:content, :not_allowed) unless board.auction.bid_allowed?(bid.to_s)
    end
  end
end
