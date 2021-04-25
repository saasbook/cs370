course_list = ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV", "OTHER"]

course_list.each_with_index do |course, i|
  Course.create!(:course_num => i + 1, :name => course, :semester => "Spring2021")
end

#Tutees have 6 digits in their SID
Tutee.create!(:ethnicity => "Asian", :gender => "Male", :sid => 111111, :first_name => "Tutee", :last_name => "One", :email => "tt1@berkeley.edu", :birthdate => "1992-01-01", :password => "111111", :password_confirmation => "111111", :confirmed_at => "2021-05-07 05:07:48")
Tutee.create!(:ethnicity => "Black/African", :gender => "Male", :sid => 222222, :first_name => "Tutee", :last_name => "Two", :email => "tt2@berkeley.edu", :birthdate => "1992-01-01", :password => "111111", :password_confirmation => "111111", :confirmed_at => "2021-05-07 05:07:48")
Tutee.create!(:ethnicity => "Asian", :gender => "Female", :sid => 333333, :first_name => "Tutee", :last_name => "Three", :email => "tt3@berkeley.edu", :birthdate => "1992-01-01", :password => "111111", :password_confirmation => "111111", :confirmed_at => "2021-05-07 05:07:48")

#Tutors have 7 digits in their SID
#hopefully this BerkeleyClass shit will be gone soon too...
BerkeleyClass.create!(:id=>"1", :CS61A=>true, :CS61B=>true, :CS61C=>true, :CS70=>true, :EE16A=>true, :CS88=>true, :CS10=>true, :DATA8=>true, :EE16B=>true, :UPPERDIV=>true, :OTHER=>true)
Tutor.create!(:sid => 1111111, :first_name => "Tutor", :last_name => "One", :email => "tr1@berkeley.edu", :password => "111111", :password_confirmation => "111111", :confirmed_at => "2021-05-07 05:07:48", :type_of_tutor => "20 hour TA", :grade_level => "3rd", :berkeley_classes_id => "1")
BerkeleyClass.create!(:id=>"2", :CS61A=>true, :CS61B=>true, :CS61C=>true, :CS70=>true, :EE16A=>false, :CS88=>false, :CS10=>false, :DATA8=>false, :EE16B=>false, :UPPERDIV=>false, :OTHER=>false)
Tutor.create!(:sid => 2222222, :first_name => "Tutor", :last_name => "Two", :email => "tr2@berkeley.edu", :password => "111111", :password_confirmation => "111111", :confirmed_at => "2021-05-07 05:07:48", :type_of_tutor => "20 hour TA", :grade_level => "3rd", :berkeley_classes_id => "2")
BerkeleyClass.create!(:id=>"3", :CS61A=>false, :CS61B=>false, :CS61C=>false, :CS70=>false, :EE16A=>true, :CS88=>true, :CS10=>true, :DATA8=>true, :EE16B=>true, :UPPERDIV=>true, :OTHER=>true)
Tutor.create!(:sid => 3333333, :first_name => "Tutor", :last_name => "Three", :email => "tr3@berkeley.edu", :password => "111111", :password_confirmation => "111111", :confirmed_at => "2021-05-07 05:07:48", :type_of_tutor => "20 hour TA", :grade_level => "3rd", :berkeley_classes_id => "3")

#Once admin is replaced with Devise system, the below will need to be scrapped.
u = Admin.new
u.id = "1"
u.password_digest = BCrypt::Password.create("123")
u.statistics_semester = "Spring2021"
u.current_semester = "Spring2021"
u.save

#tt1 requests 61A tutoring
Request.create!(:id=>1,:tutee_id=>1,:course_id=>2,:meeting_length=>60,:subject=>"seeded request tutee 1", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")

#Meeting proposed for tt2 by tr2
Request.create!(:id=>"2",:tutee_id=>"2",:course_id=>"3",:meeting_length=>60,:subject=>"seeded request tutee 2", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Evaluation.create!(:id=>"2", :status=>"Pending")
Meeting.create!(:id=>"2", :tutor_id=>"2", :tutee_id=>"2", :request_id=>"2", :evaluation_id=>"2")

#2 past meetings that have occurred
Request.create!(:id=>"3",:tutee_id=>"3",:course_id=>"1",:meeting_length=>120,:subject=>"seeded request tutee 2", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Evaluation.create!(:id=>"3", :took_place=>true, :status=>"Complete", :hours=>2,
	:knowledgeable=> 1)
Meeting.create!(:id=>"3", :tutor_id=>"2", :tutee_id=>"3", :request_id=>"3", :evaluation_id=>"3")

Request.create!(:id=>"4",:tutee_id=>"1",:course_id=>"6",:meeting_length=>120,:subject=>"seeded request tutee 2", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Evaluation.create!(:id=>"4", :took_place=>true, :status=>"Complete", :hours=>5,
	:knowledgeable=> 4)
Meeting.create!(:id=>"4", :tutor_id=>"2", :tutee_id=>"1", :request_id=>"4", :evaluation_id=>"4")

Request.create!(:id=>"5",:tutee_id=>"3",:course_id=>"1",:meeting_length=>120,:subject=>"seeded request tutee 2", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Evaluation.create!(:id=>"5", :took_place=>true, :status=>"Complete", :hours=>2,
	:knowledgeable=> 5)
Meeting.create!(:id=>"5", :tutor_id=>"2", :tutee_id=>"3", :request_id=>"5", :evaluation_id=>"5")

QuestionTemplate.create!(:prompt=>"How many hours of tutoring did you receive?", :is_optional=>false, :question_type=>"text", :order=>1, :is_active=>true) #is this text? do we need a "number" category?
QuestionTemplate.create!(:prompt=>"What did you like about how your tutor covered the material?", :is_optional=>false, :question_type=>"text", :order=>2, :is_active=>true)
QuestionTemplate.create!(:prompt=>"What is the best thing that your tutor did?", :is_optional=>false, :question_type=>"text", :order=>3, :is_active=>true)
QuestionTemplate.create!(:prompt=>"What is something your tutor could work to improve?", :is_optional=>false, :question_type=>"text", :order=>4, :is_active=>true)
QuestionTemplate.create!(:prompt=>"How knowledgeable was your tutor?", :is_optional=>false, :question_type=>"scale", :order=>5, :is_active=>true)
QuestionTemplate.create!(:prompt=>"How supportive was your tutor?", :is_optional=>false, :question_type=>"scale", :order=>6, :is_active=>true)
QuestionTemplate.create!(:prompt=>"How clear were your tutor's explanations?", :is_optional=>false, :question_type=>"scale", :order=>7, :is_active=>false)
QuestionTemplate.create!(:prompt=>"How was the pacing of the appointment?", :is_optional=>false, :question_type=>"scale", :order=>8, :is_active=>false)
QuestionTemplate.create!(:prompt=>"Any other concerns?", :is_optional=>true, :question_type=>"text", :order=>9, :is_active=>true)
