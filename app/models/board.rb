class Board < ActiveRecord::Base
  has_many :bids,  -> { order(:created_at) }
  has_many :cards, -> { order(:created_at) }

  validates :deal_id,    presence: true
  validates :dealer,     presence: true, inclusion: Bridge::DIRECTIONS
  validates :vulnerable, presence: true, inclusion: Bridge::VULNERABILITIES

  def auction
    Bridge::Auction.new(dealer, bids.reload.map(&:content))
  end
end
