# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tutees = [{:sid => 123456789, :first_name => "Bob", :last_name => "Burgers", :email => "bobs@berkeley.edu", :birthdate => "1992-01-01", :privilege => 'No', :gender => 'male',
          :ethnicity => 'Asian', :dsp => 'Yes', :transfer => 'Yes', :year => '4+', :pronoun => 'he/his', :major => 'EECS'}]
courses = [{:course_num => 1, :name => "CS61A", :semester => "Sp2019"}]
requests = [{:tutee_id => 1, :course_id => 1, :subject => "tree"}]

tutees.each do |tutee|
  Tutee.create!(tutee)
end

courses.each do |course|
  Course.create!(course)
end

requests.each do |request|
  Request.create!(request)
end

def seed_tutor
  10.times do
    Tutor.create(
    	type_of_tutor: "CSM",
      	grade_level: "Senior",
   		email: "test@berkeley.edu", 
      	first_name: "Alvin",
      	last_name: "Nguyen",

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

BERKELEY_CLASSES = BerkeleyClass.all 
TUTORS = Tutor.all 

BERKELEY_CLASSES.each_with_index do |item, index|
  TUTORS[index].update_column(:berkeley_classes_id, item.id)
end
