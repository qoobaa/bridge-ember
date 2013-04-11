class ClaimSerializer < ActiveModel::Serializer
  attributes :direction, :tricks, :accepted_directions, :rejected_directions
end
