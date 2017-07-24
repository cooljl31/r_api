class Item < ApplicationRecord
  belongs_to :todo, class_name: "Todo", foreign_key: "todo_id"
  validates_presence_of :name
end
