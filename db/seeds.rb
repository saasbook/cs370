course_list = ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV", "OTHER"]

course_list.each_with_index do |course, i|
  Course.create!(:course_num => i + 1, :name => course, :semester => "Spring 2019")
end


<<<<<<< HEAD
Tutee.create!(:sid => 12345678, :first_name => "Tutee", :last_name => "Tutee", :email => "tutee@berkeley.edu", :birthdate => "1992-01-01", :password => "1234abcd", :password_confirmation => "1234abcd", :confirmed_at => "2019-05-07 05:07:48")
Tutor.create!(:sid => 12345678, :first_name => "Tutor", :last_name => "Tutor", :email => "tutor@berkeley.edu", :password => "1234abcd", :password_confirmation => "1234abcd", :confirmed_at => "2019-05-07 05:07:48", :type_of_tutor => "20 hour TA", :grade_level => "3rd", :berkeley_classes_id => "1")
BerkeleyClass.create!(id: 1, CS61A: true, CS61B: true, CS61C: true, CS70: true, EE16A: true, CS88: true, CS10: true, DATA8: true, EE16B: true, UPPERDIV: true, OTHER: true)
Meeting.create!(id: 5, tutor_id: 4, request_id: 1, evaluation_id: 5, meta_values: nil, created_at: "2021-03-07 04:33:30", updated_at: "2021-03-07 04:33:51", times: [], set_time: "2021-03-10 08:34:00", tutee_id: 3, locations: ["12341234", "12341234123", "2341234123"], set_location: "2341234123", is_scheduled: true)
=======
#Tutee.create!(:sid => 12345678, :first_name => "Tutee", :last_name => "Tutee", :email => "tutee@berkeley.edu", :birthdate => "1992-01-01", :password => "1234abcd", :password_confirmation => "1234abcd", :confirmed_at => "2019-05-07 05:07:48")
#BerkeleyClass.create!(id: 1, CS61A: true, CS61B: true, CS61C: true, CS70: true, EE16A: true, CS88: true, CS10: true, DATA8: true, EE16B: true, UPPERDIV: true, OTHER: true)
#Tutor.create!(:sid => 12345678, :first_name => "Tutor", :last_name => "Tutor", :email => "tutor@berkeley.edu", :password => "1234abcd", :password_confirmation => "1234abcd", :confirmed_at => "2019-05-07 05:07:48", :type_of_tutor => "20 hour TA", :grade_level => "3rd", :berkeley_classes_id => "1")
#Meeting.create!(id: 1, tutor_id: 1, request_id: 1, evaluation_id: 1, meta_values: nil, created_at: "2021-03-07 04:33:30", updated_at: "2021-03-07 04:33:51", times: [], set_time: "2021-03-10 08:34:00", tutee_id: 1, locations: ["12341234", "12341234123", "2341234123"], set_location: "2341234123", is_scheduled: true)
>>>>>>> 15ab9668765ddecb3af6d7056b280b0186d8f70f
