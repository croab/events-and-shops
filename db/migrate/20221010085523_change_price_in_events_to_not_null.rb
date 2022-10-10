class ChangePriceInEventsToNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :price, :float, null: false
  end
end
