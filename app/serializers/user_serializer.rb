class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :socket_id
end
