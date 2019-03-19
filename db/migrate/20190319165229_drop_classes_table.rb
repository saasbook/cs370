class DropClassesTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :classes
  end
end
