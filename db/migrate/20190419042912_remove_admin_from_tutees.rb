class RemoveAdminFromTutees < ActiveRecord::Migration[5.2]
  def change
    remove_column :tutees, :admin, :boolean
  end
end
