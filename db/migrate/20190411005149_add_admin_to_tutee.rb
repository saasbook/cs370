class AddAdminToTutee < ActiveRecord::Migration[5.2]
  def change
    add_column :tutees, :admin, :boolean, default: false
  end
end
