# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def seed_tutor
  10.times do
    Tutor.create(
    	type_of_tutor: "CSM",
      	grade_level: "Senior",
   		email: "test@email.edu", 
      	first_name: "Alvin",
      	last_name: "Nguyen"
    )
	end
end

def seed_berkeley_classes 
  	10.times do 
		BerkeleyClass.create!(
			CS61A: true,
	    	CS61B: true,
	    	CS61C: true,	
	    	CS70: false,
	    	EE16A: false,
	    	CS88: false,
	    	CS10: false,
	    	DATA8: false
    	)
	end
end

seed_berkeley_classes
seed_tutor


