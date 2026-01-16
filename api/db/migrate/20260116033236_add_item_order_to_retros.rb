class AddItemOrderToRetros < ActiveRecord::Migration[8.1]
  def change
    add_column :retros, :item_order, :string, default: 'time'
  end
end
