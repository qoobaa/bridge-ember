class BidSerializer < ActiveModel::Serializer
  attributes :content

  def content
    if (direction = object.board.user_direction(current_user)) && !object.board.visible_alert_for?(object.content, direction)
      object.content
    else
      object.compact
    end
  end
end
