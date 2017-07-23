class TodoSerializer < ActiveModel::Serializer
  attributes :id, :items, :created_by, :title
end
