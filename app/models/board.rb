class Board < ActiveRecord::Base
  %w[n e s w].each { |direction| belongs_to :"user_#{direction}", class_name: "User" }
  has_many :bids,  -> { order(:created_at) }
  has_many :cards, -> { order(:created_at) }
  belongs_to :table

  validates :user_n_id,  presence: true
  validates :user_e_id,  presence: true
  validates :user_s_id,  presence: true
  validates :user_w_id,  presence: true
  validates :deal_id,    presence: true
  validates :dealer,     presence: true, inclusion: Bridge::DIRECTIONS
  validates :vulnerable, presence: true, inclusion: Bridge::VULNERABILITIES

  def auction
    Bridge::Auction.new(dealer, bids.reload.pluck(:content))
  end

  def play
    Bridge::Play.new(deal_id.to_i, contract, cards.reload.pluck(:content))
  end

  def deal
    Bridge::Deal.from_id(deal_id.to_i) if deal_id.present?
  end

  def user_direction(user)
    case user
    when user_n then "N"
    when user_e then "E"
    when user_s then "S"
    when user_w then "W"
    end
  end
end
