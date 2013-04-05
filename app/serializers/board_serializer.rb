class BoardSerializer < ActiveModel::Serializer
  attributes :dealer, :vulnerable, :bids, :cards

  def bids
    object.bids.pluck(:content)
  end

  def cards
    object.cards.pluck(:content)
  end
end
