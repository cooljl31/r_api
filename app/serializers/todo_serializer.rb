class TodoSerializer < ActiveModel::Serializer
  attributes :id, :created_by, :title, :created_at, :updated_at
  has_many :items
end
