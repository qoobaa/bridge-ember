class Board < ActiveRecord::Base
  %w[n e s w].each { |direction| belongs_to :"user_#{direction}", class_name: "User" }
  has_many :bids,   -> { order(:created_at) }
  has_many :cards,  -> { order(:created_at) }
  has_many :claims, -> { order(:created_at) }
  belongs_to :table

  default_scope include: [:bids, :cards, :claims]

  validates :user_n_id,  presence: true
  validates :user_e_id,  presence: true
  validates :user_s_id,  presence: true
  validates :user_w_id,  presence: true
  validates :deal_id,    presence: true
  validates :dealer,     presence: true, inclusion: Bridge::DIRECTIONS
  validates :vulnerable, presence: true, inclusion: Bridge::VULNERABILITIES
  validates :result,     inclusion: {in: -13..6, allow_nil: true}

  def auction
    Bridge::Auction.new(dealer, bids.reload.pluck(:content))
  end

  def play
    Bridge::Play.new(deal_id.to_i, contract, cards.reload.pluck(:content)) if contract?
  end

  def deal
    Bridge::Deal.from_id(deal_id.to_i) if deal_id.present?
  end

  def score
    Bridge::Score.new(contract, vulnerable, total_declarer_tricks_number) if play.finished? || claims.last.try!(:accepted?)
  end

  def user_direction(user)
    case user
    when user_n then "N"
    when user_e then "E"
    when user_s then "S"
    when user_w then "W"
    end
  end

  def visible_hand_for?(hand, direction)
    return true if hand == direction # Always see own hand
    if claim = claims.last
      return true if claim.active? && claim.direction == hand # Claimed user hand is visible to all
    end
    if cards.count > 0
      hand == play.dummy || # Dummy's cards are visible for all after first lead
      play.dummy == direction # Dummy can see all hands after first lead
    end
  end

  def visible_alert_for?(bid, direction)
    bid_direction = auction.directions[bids.pluck(:content).index(bid)]
    Bridge.partner_of(bid_direction) != direction # Don't display alert to partner
  end

  def complete?
    result?
  end

  private

  def total_declarer_tricks_number
    claim = claims.last
    play.declarer_tricks_number + (claim.try!(:accepted?) ? claim.declarer_tricks_number : 0)
  end
end
