class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :created_at,
             :updated_at,
             :email,
             :username,
             :name,
             :company
end
