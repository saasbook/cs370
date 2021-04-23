class AddSignupsAllowedToAdmins < ActiveRecord::Migration[5.2]
  def change
  	add_column :admins, :signups_allowed, :boolean, :default => true
  end
end
