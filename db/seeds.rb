course_list = ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV", "OTHER"]
course_list.each_with_index do |course, i|
	Course.create(:course_num => i + 1, :name => course, :semester => "Spring2021")
end

admin_password = BCrypt::Password.create(Admin.general_seed_password)
Admin.create(id:1, password_digest:admin_password, statistics_semester:"Spring2021", current_semester:"Spring2021", tutor_types:"CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)", priority_list:[333333])

if not Rails.env.production?
	#Tutees have 6 digits in their SID
	#use Admin.general_seed_password for reliability, single source of truth. All users have the same password for testing purposes.
	#this seeds.rb file is being used in cucumber tests as well, so consistency is key.
	Tutee.create(
	  sid: 111111, first_name: "Tutee", last_name: "One", email: "tt1@berkeley.edu", gender: "Male", pronoun: "He/His", ethnicity: ['Vietnamese'], major: 'Intended Computer Science', dsp: false, transfer: false, term: "8",
	  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
	Tutee.create(
	  sid: 222222, first_name: "Tutee", last_name: "Two", email: "tt2@berkeley.edu", gender: "Non-Binary", pronoun: "Other", ethnicity: ['White', 'Black or African American'], major: 'Declared Data Science', dsp: false, transfer: true, term: "4",
	  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
	Tutee.create(
	  sid: 333333, first_name: "Tutee", last_name: "Three", email: "tt3@berkeley.edu", gender: "Female", pronoun: "She/Hers", ethnicity: ['Chinese', 'White'], major: 'Intended Cognitive Science', dsp: false, transfer: false, term: "2",
	  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")

	#Tutors have 7 digits in their SID
	#hopefully this BerkeleyClass shit will be gone soon too...
	BerkeleyClass.create(:CS61A=>true, :CS61B=>true, :CS61C=>true, :CS70=>true, :EE16A=>true, :CS88=>true, :CS10=>true, :DATA8=>true, :EE16B=>true, :UPPERDIV=>true, :OTHER=>true)
	Tutor.create(:sid => 1111111, :first_name => "Tutor", :last_name => "One", :email => "tr1@berkeley.edu", :password => Admin.general_seed_password, :password_confirmation => Admin.general_seed_password, :confirmed_at => "2021-05-07 05:07:48", :type_of_tutor => "20 hour TA", :term => "5", :berkeley_classes_id => "1")
	BerkeleyClass.create(:CS61A=>true, :CS61B=>true, :CS61C=>true, :CS70=>true, :EE16A=>false, :CS88=>false, :CS10=>false, :DATA8=>false, :EE16B=>false, :UPPERDIV=>false, :OTHER=>false)
	Tutor.create(:sid => 2222222, :first_name => "Tutor", :last_name => "Two", :email => "tr2@berkeley.edu", :password => Admin.general_seed_password, :password_confirmation => Admin.general_seed_password, :confirmed_at => "2021-05-07 05:07:48", :type_of_tutor => "20 hour TA", :term => "3", :berkeley_classes_id => "2")
	BerkeleyClass.create(:CS61A=>false, :CS61B=>false, :CS61C=>false, :CS70=>false, :EE16A=>true, :CS88=>true, :CS10=>true, :DATA8=>true, :EE16B=>true, :UPPERDIV=>true, :OTHER=>true)
	Tutor.create(:sid => 3333333, :first_name => "Tutor", :last_name => "Three", :email => "tr3@berkeley.edu", :password => Admin.general_seed_password, :password_confirmation => Admin.general_seed_password, :confirmed_at => "2021-05-07 05:07:48", :type_of_tutor => "20 hour TA", :term => "3", :berkeley_classes_id => "3")

	#3 past meetings that have occurred between tr2 and all three tts
	Request.create(:tutee_id=>"1",:course_id=>"1",:meeting_length=>120,:subject=>"seeded request tutee 1 - 1", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
	Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>2,
		:knowledgeable=> 1)
	Meeting.create(:tutor_id=>"2", :tutee_id=>"1", :request_id=>"1", :evaluation_id=>"1", is_done: true)

	Request.create(:tutee_id=>"2",:course_id=>"6",:meeting_length=>120,:subject=>"seeded request tutee 2 - 1", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
	Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>5,
		:knowledgeable=> 4)
	Meeting.create(:tutor_id=>"2", :tutee_id=>"2", :request_id=>"2", :evaluation_id=>"2", is_done: true)

	Request.create(:tutee_id=>"3",:course_id=>"1",:meeting_length=>120,:subject=>"seeded request tutee 3 - 1", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
	Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>2,
		:knowledgeable=> 5)
	Meeting.create(:tutor_id=>"2", :tutee_id=>"3", :request_id=>"3", :evaluation_id=>"3", is_done: true)

	#One past meeting occurred between tr1 and tt1
	Request.create(:tutee_id=>"1",:course_id=>"1",:meeting_length=>120,:subject=>"seeded request tutee 1 - 2", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
	Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>2,
		:knowledgeable=> 5)
	Meeting.create(:tutor_id=>"1", :tutee_id=>"1", :request_id=>"4", :evaluation_id=>"4", is_done: true)

	#tt1 requests 61A tutoring
	Request.create(:tutee_id=>"1",:course_id=>"2",:meeting_length=>60,:subject=>"seeded request tutee 1 - 3", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")

	#Meeting proposed for tt2 by tr2
	Request.create(:tutee_id=>"2",:course_id=>"3",:meeting_length=>60,:subject=>"seeded request tutee 2 - 2", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
	Evaluation.create(:status=>"Pending")
	Meeting.create(:tutor_id=>"2", :tutee_id=>"2", :request_id=>"6", :evaluation_id=>"5")
end
