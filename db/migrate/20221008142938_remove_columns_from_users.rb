class RemoveColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :site_admin
    remove_column :users, :verified
  end
end
