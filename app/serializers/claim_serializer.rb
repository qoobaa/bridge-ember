class ClaimSerializer < ActiveModel::Serializer
  attributes :id, :direction, :tricks, :accepted, :rejected
end
