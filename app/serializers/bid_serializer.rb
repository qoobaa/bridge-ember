class BidSerializer < ActiveModel::Serializer
  attributes :id, :board_id, :content
end
