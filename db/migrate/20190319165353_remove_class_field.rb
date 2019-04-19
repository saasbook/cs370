class RemoveClassField < ActiveRecord::Migration[5.2]
  def change
  	remove_column :tutors, :classes_id
  end
end
