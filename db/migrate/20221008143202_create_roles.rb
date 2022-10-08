class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.boolean :admin, null: false, default: false
      t.boolean :verified_user, null: false, default: false

      t.timestamps
    end
  end
end
