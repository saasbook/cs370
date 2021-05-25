 class AddIsDone < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :is_done, :boolean, default: false
  end
end
