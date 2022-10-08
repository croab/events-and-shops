class AddColumnsToShops < ActiveRecord::Migration[7.0]
  def change
    add_column :shops, :location, :string
    add_column :shops, :shop_url, :string
  end
end
