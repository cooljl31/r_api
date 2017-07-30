class AddItemsDoneDefaultFalse < ActiveRecord::Migration[5.1]
  def change
   change_column :items, :done, :string, default: false
  end
end
