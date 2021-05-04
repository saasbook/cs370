QuestionTemplate.create!(:prompt=>"What did you like about how your tutor covered the material?", :is_optional=>false, :question_type=>"text", :order=>1, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 50})
QuestionTemplate.create!(:prompt=>"What is the best thing that your tutor did?", :is_optional=>false, :question_type=>"text", :order=>2, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 50})
QuestionTemplate.create!(:prompt=>"What is something your tutor could work to improve?", :is_optional=>false, :question_type=>"text", :order=>3, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 50})
QuestionTemplate.create!(:prompt=>"How knowledgeable was your tutor?", :is_optional=>false, :question_type=>"scale", :order=>4, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Knowledgeable', :max_val => 10, :max_lab => "Very Knowledgeable", :descriptor => "Knowledgeable"})
QuestionTemplate.create!(:prompt=>"How supportive was your tutor?", :is_optional=>false, :question_type=>"scale", :order=>5, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Supportive', :max_val => 10, :max_lab => "Very Supportive", :descriptor => "Supportive"})
QuestionTemplate.create!(:prompt=>"How clear were your tutor's explanations?", :is_optional=>false, :question_type=>"scale", :order=>6, :is_active=>false, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Clear', :max_val => 10, :max_lab => "Very Clear", :descriptor => "Clarity"})
QuestionTemplate.create!(:prompt=>"How was the pacing of the appointment?", :is_optional=>false, :question_type=>"scale", :order=>7, :is_active=>false, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Too Slow', :max_val => 10, :max_lab => "Too Fast", :descriptor => "Pacing"})
QuestionTemplate.create!(:prompt=>"Any other concerns?", :is_optional=>true, :question_type=>"text", :order=>8, :is_active=>true, :is_admin_only=>true, :details=>{:min_char => 0})

admin_password = BCrypt::Password.create(Admin.general_seed_password)
Admin.create(id:1, password_digest:admin_password, tutor_types:"CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)",
  priority_list:[333333], course_list: ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV"])

if not Rails.env.production?
  #Tutees have 6 digits in their SID
  #use Admin.general_seed_password for reliability, single source of truth. All users have the same password for testing purposes.
  #this seeds.rb file is being used in cucumber tests as well, so consistency is key.
  Tutee.create(
    sid: 111111, first_name: "Tutee", last_name: "One", email: "tt1@berkeley.edu", gender: "Male", pronoun: "He/His",
    ethnicity: ['Vietnamese'], major: 'Intended Computer Science', dsp: false, transfer: false, term: "8",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
  Tutee.create(
    sid: 222222, first_name: "Tutee", last_name: "Two", email: "tt2@berkeley.edu", gender: "Non-Binary", pronoun: "Other",
    ethnicity: ['White', 'Black or African American'], major: 'Declared Data Science', dsp: false, transfer: true, term: "4",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
  Tutee.create(
    sid: 333333, first_name: "Tutee", last_name: "Three", email: "tt3@berkeley.edu", gender: "Female", pronoun: "She/Hers",
    ethnicity: ['Chinese', 'White'], major: 'Intended Cognitive Science', dsp: false, transfer: false, term: "2",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")

  #Tutors have 7 digits in their SID
  #hopefully this BerkeleyClass shit will be gone soon too...
  Tutor.create(:sid => 1111111, :first_name => "Tutor", :last_name => "One", :email => "tr1@berkeley.edu", type_of_tutor: "CSM (8-10 hours)",
    gender: "Male", dsp: false, transfer: true, :password => Admin.general_seed_password, :major => "Declared Computer Science", :password_confirmation => Admin.general_seed_password,
    :confirmed_at => "2021-05-07 05:07:48", :term => "5")
  Tutor.create(:sid => 2222222, :first_name => "Tutor", :last_name => "Two", :email => "tr2@berkeley.edu", type_of_tutor: "TA (12 hours)",
    gender: "Female", dsp: true, transfer: false, :password => Admin.general_seed_password, :major => "Intended Data Science", :password_confirmation => Admin.general_seed_password,
    :confirmed_at => "2021-05-07 05:07:48", :term => "3")
  Tutor.create(:sid => 3333333, :first_name => "Tutor", :last_name => "Three", :email => "tr3@berkeley.edu", type_of_tutor: "Academic Intern (36 hours)",
    gender: "Non-Binary", dsp: true, transfer: true, :password => Admin.general_seed_password, :major => "Intended Other", :password_confirmation => Admin.general_seed_password,
    :confirmed_at => "2021-05-07 05:07:48", :term => "6")


  #3 past meetings that have occurred between tr2 and all three tts
  Request.create(:tutee_id=>"1",:course=>"CS61A",:meeting_length=>2,:subject=>"seeded request tutee 1 - 1", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>2)
  Meeting.create(:tutor_id=>"2", :tutee_id=>"1", :request_id=>"1", :evaluation_id=>"1", is_done: true)

  Request.create(:tutee_id=>"2",:course=>"CS88",:meeting_length=>2,:subject=>"seeded request tutee 2 - 1", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>5)
  Meeting.create(:tutor_id=>"2", :tutee_id=>"2", :request_id=>"2", :evaluation_id=>"2", is_done: true)

  Request.create(:tutee_id=>"3",:course=>"CS70",:meeting_length=>2,:subject=>"seeded request tutee 3 - 1", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>2)
  Meeting.create(:tutor_id=>"2", :tutee_id=>"3", :request_id=>"3", :evaluation_id=>"3", is_done: true)

  #One past meeting occurred between tr1 and tt1
  Request.create(:tutee_id=>"1",:course=>"CS10",:meeting_length=>2,:subject=>"seeded request tutee 1 - 2", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Evaluation.create(:took_place=>true, :status=>"Complete", :hours=>2)
  Meeting.create(:tutor_id=>"1", :tutee_id=>"1", :request_id=>"4", :evaluation_id=>"4", is_done: true)

  #tt1 requests 61A tutoring
  Request.create(:tutee_id=>"1",:course=>"CS61B",:meeting_length=>1,:subject=>"seeded request tutee 1 - 3", :status=>"open", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")

  #Meeting proposed for tt2 by tr2
  Request.create(:tutee_id=>"2",:course=>"CS61A",:meeting_length=>1,:subject=>"seeded request tutee 2 - 2", :status=>"matched", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Evaluation.create(:status=>"Pending")
  Meeting.create(:tutor_id=>"2", :tutee_id=>"2", :request_id=>"6", :evaluation_id=>"5")
end
