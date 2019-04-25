# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tutees = [{:sid => 123456789, :first_name => "Bob", :last_name => "Burgers", :email => "bobs@berkeley.edu", :birthdate => "1992-01-01", :privilege => 'No', :gender => 'male',
          :ethnicity => 'Asian', :dsp => 'Yes', :transfer => 'Yes', :year => '4+', :pronoun => 'he/his', :major => 'EECS'}]
tutee_cs_scholar = {:sid => 123456789, :first_name => "Peter", :last_name => "Griffin", :email => "bobs@berkeley.edu", :birthdate => "1992-01-01", :privilege => 'cs61a', :gender => 'male',
          :ethnicity => 'Asian', :dsp => 'Yes', :transfer => 'Yes', :year => '4+', :pronoun => 'he/his', :major => 'EECS'}
tutee_not_cs_scholar = {:sid => 123456789, :first_name => "Naruto", :last_name => "Uzumaki", :email => "bobs@berkeley.edu", :birthdate => Time.now, :privilege => 'No', :gender => 'male',
          :ethnicity => 'Asian', :dsp => 'Yes', :transfer => 'Yes', :year => '4+', :pronoun => 'he/his', :major => 'EECS'}
# courses = [{:course_num => 1, :name => "CS61A", :semester => "Sp2019"}]
course_list = ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8"]
requests = [{:tutee_id => 1, :course_id => 1, :subject => "tree"}]

course_list.each_with_index do |course, index|
  Course.create!(:course_num => index, :name => course, :semester => "Sp2019")
end

tutees.each do |tutee|
  Tutee.create!(tutee)
end

# courses.each do |course|
#   Course.create!(course)
# end

requests.each do |request|
  Request.create!(request)
end

10.times do
  Tutor.create(
  	type_of_tutor: "CSM",
    	grade_level: "4th",
 		email: "test@berkeley.edu", 
    	first_name: "Alvin",
    	last_name: "Nguyen",
      birthday: Time.now,
      gender: "Male",
      sid: 4208470238,
      major: "Cognitive Science", 
      dsp?: false,
      transfer?: false
  )
end

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

10.times do 
  Tutee.create!(tutee_cs_scholar)
  Tutee.create!(tutee_not_cs_scholar)
end

BERKELEY_CLASSES = BerkeleyClass.all 
TUTORS = Tutor.all 

BERKELEY_CLASSES.each_with_index do |item, index|
  TUTORS[index].update_column(:berkeley_classes_id, item.id)
end
