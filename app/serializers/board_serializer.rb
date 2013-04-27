class BoardSerializer < ActiveModel::Serializer
  attributes :id, :dealer, :vulnerable, :bids, :cards, :n, :e, :s, :w, :result
  has_one :claim

  %w[n e s w].each do |direction|
    define_method(direction) do
      if current_user && object.visible_hand_for?(direction.upcase, object.user_direction(current_user))
        object.deal[direction.upcase].map(&:to_s)
      end
    end
  end

  def claim
    object.claims.last
  end

  def bids
    object.bids.map do |bid|
      BidSerializer.new(bid, scope: current_user, scope_name: :current_user).serializable_hash[:content]
    end
  end

  def cards
    object.cards.pluck(:content)
  end
end
