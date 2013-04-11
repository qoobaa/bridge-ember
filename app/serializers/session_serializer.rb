class SessionSerializer < ActiveModel::Serializer
  attributes :id, :email, :socket_id
end
