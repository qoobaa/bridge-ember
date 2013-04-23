class BidSerializer < ActiveModel::Serializer
  attribute :compact, key: :content
end
