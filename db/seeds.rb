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
    	type_of_tutor: "CS61A",
      	grade_level: "Senior",
      	classes_id: 1234,
   		email: "test@email.edu", 
      	first_name: "Alvin",
      	last_name: "Nguyen"
    )
  end
end

seed_tutor

