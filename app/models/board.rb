class Board < ActiveRecord::Base
  validates :deal_id,    presence: true
  validates :dealer,     presence: true
  validates :vulnerable, presence: true
end
