class RemoveQuantityFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :quantity
  end
end
