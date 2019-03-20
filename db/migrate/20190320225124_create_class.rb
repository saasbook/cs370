class CreateClass < ActiveRecord::Migration[5.2]
  def change
    create_table :classes do |t|
      t.integer :class
      t.string :name
      t.string :semester
      t.json :meta_values
      t.timestamps
    end
  end
end
