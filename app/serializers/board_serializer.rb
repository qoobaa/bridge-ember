class BoardSerializer < ActiveModel::Serializer
  attributes :dealer, :vulnerable, :bids, :cards, :n, :e, :s, :w

  %w[n e s w].each do |direction|
    define_method(direction) { object.deal[direction.upcase].map(&:to_s) }
  end

  def bids
    object.bids.pluck(:content)
  end

  def cards
    object.cards.pluck(:content)
  end
end
