class TableSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user_n, :user_e, :user_s, :user_w
  has_one :board

  def board
    object.boards.last
  end
end
