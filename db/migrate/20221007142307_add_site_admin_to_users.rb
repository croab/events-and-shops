class AddSiteAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :site_admin, :boolean, null: false, default: false
  end
end
