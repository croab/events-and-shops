class CreateShopAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :shop_admins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
