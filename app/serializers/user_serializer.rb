class UserSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :created_at
end
