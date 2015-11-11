class DeviceSessionSerializer < ActiveModel::Serializer
  attributes :authentication_token, :created_at
end
