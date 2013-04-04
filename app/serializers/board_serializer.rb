class BoardSerializer < ActiveModel::Serializer
  attributes :dealer, :vulnerable, :contract
  has_many :bids
  has_many :cards
end
