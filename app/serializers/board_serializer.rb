class BoardSerializer < ActiveModel::Serializer
  attributes :id, :dealer, :vulnerable, :bids, :cards, :n, :e, :s, :w, :result
  has_one :claim

  %w[n e s w].each do |direction|
    define_method(direction) { object.deal[direction.upcase].map(&:to_s) }
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

  # Authorization
  def include_n?
    return false if !current_user
    object.visible_hand_for?("N", object.user_direction(current_user))
  end

  def include_e?
    return false if !current_user
    object.visible_hand_for?("E", object.user_direction(current_user))
  end

  def include_s?
    return false if !current_user
    object.visible_hand_for?("S", object.user_direction(current_user))
  end

  def include_w?
    return false if !current_user
    object.visible_hand_for?("W", object.user_direction(current_user))
  end
end
