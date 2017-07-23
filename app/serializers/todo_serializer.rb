class TodoSerializer < ActiveModel::Serializer
  attributes :id, :done, :items, :created_by, :name
end
