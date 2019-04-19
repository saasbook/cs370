class AddBerkeleyClassToTutors < ActiveRecord::Migration[5.2]
def change
	add_reference :tutors, :berkeley_classes, foreign_key: true
  end
end
