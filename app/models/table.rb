class Table < ActiveRecord::Base
  %w[n e s w].each { |direction| belongs_to :"user_#{direction}", class_name: "User" }
  has_many :boards, -> { order(:created_at) }

  def online?
    publish(event: "ping") > 0
  end

  def board
    boards.last
  end

  def users
    [user_n, user_e, user_s, user_w].compact
  end

  def create_board!
    attributes = self.attributes.slice("user_n_id", "user_e_id", "user_s_id", "user_w_id")
    attributes[:deal_id] = Bridge::Deal.random_id.to_s
    attributes[:dealer] = Bridge.next_direction(board.try(:dealer))
    attributes[:vulnerable] = Bridge.vulnerable_in_deal(boards.count + 1)

    boards.create!(attributes)
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
