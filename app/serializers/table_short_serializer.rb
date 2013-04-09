class TableShortSerializer < ActiveModel::Serializer
  self.root = "table"

  attributes :id
  has_one :user_n, :user_e, :user_s, :user_w
end
