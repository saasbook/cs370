class AddActiveToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :active, :boolean, default: true
  end
end
