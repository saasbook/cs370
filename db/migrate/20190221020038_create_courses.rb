class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :course_num
      t.string :name
      t.string :semester
      t.json :meta_values
      t.timestamps
    end
  end
end
