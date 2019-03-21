class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :course
      t.string :name
      t.string :semester
      t.json :meta_values
      t.timestamps
    end
  end
end
