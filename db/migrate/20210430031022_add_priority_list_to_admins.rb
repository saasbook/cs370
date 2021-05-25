class AddPriorityListToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :priority_list, :integer, :array=>true
  end
end
