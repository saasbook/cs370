class CreateTutors < ActiveRecord::Migration[5.2]
  def change
    create_table :tutors do |t|
      t.string :type_of_tutor
      t.string :grade_level 
      t.int :classes_id
      t.string :email 
      t.string :first_name
      t.string  :last_name
      t.timestamps
    end
  end
end
