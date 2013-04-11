class ClaimSerializer < ActiveModel::Serializer
  attributes :id, :direction, :tricks, :accepted_directions, :rejected_directions
end
