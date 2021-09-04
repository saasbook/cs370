QuestionTemplate.create!(:prompt=>"What did you like about how your tutor covered the material?", :is_optional=>false, :question_type=>"text", :order=>1, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 50})
QuestionTemplate.create!(:prompt=>"What is the best thing that your tutor did?", :is_optional=>false, :question_type=>"text", :order=>2, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 50})
QuestionTemplate.create!(:prompt=>"What is something your tutor could work to improve?", :is_optional=>false, :question_type=>"text", :order=>3, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 50})
QuestionTemplate.create!(:prompt=>"How knowledgeable was your tutor?", :is_optional=>false, :question_type=>"scale", :order=>4, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Knowledgeable', :max_val => 10, :max_lab => "Very Knowledgeable", :descriptor => "Knowledgeable"})
QuestionTemplate.create!(:prompt=>"How supportive was your tutor?", :is_optional=>false, :question_type=>"scale", :order=>5, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Supportive', :max_val => 10, :max_lab => "Very Supportive", :descriptor => "Supportive"})
QuestionTemplate.create!(:prompt=>"How clear were your tutor's explanations?", :is_optional=>false, :question_type=>"scale", :order=>6, :is_active=>false, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Clear', :max_val => 10, :max_lab => "Very Clear", :descriptor => "Clarity"})
QuestionTemplate.create!(:prompt=>"How was the pacing of the appointment?", :is_optional=>false, :question_type=>"scale", :order=>7, :is_active=>false, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Too Slow', :max_val => 10, :max_lab => "Too Fast", :descriptor => "Pacing"})
QuestionTemplate.create!(:prompt=>"Any other concerns?", :is_optional=>true, :question_type=>"text", :order=>8, :is_active=>true, :is_admin_only=>true, :details=>{:min_char => 0})

admin_password = BCrypt::Password.create(Admin.general_seed_password)
Admin.create(id:1, password_digest:admin_password)

if not Rails.env.production?
  #Tutees have 6 digits in their SID
  #use Admin.general_seed_password for reliability, single source of truth. All users have the same password for testing purposes.
  Tutee.create( #user 1
    first_name: "Tutee", last_name: "One", email: "tt1@berkeley.edu", gender: "Male", pronoun: "He/His",
    ethnicity: ['Vietnamese'], major: 'Intended Computer Science', dsp: false, transfer: false, term: "8",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
  Tutee.create(
    first_name: "Tutee", last_name: "Two", email: "tt2@berkeley.edu", gender: "Non-Binary", pronoun: "Other",
    ethnicity: ['White', 'Black or African American'], major: 'Declared Data Science', dsp: false, transfer: true, term: "4",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
  Tutee.create(
    first_name: "Tutee", last_name: "Three", email: "tt3@berkeley.edu", gender: "Female", pronoun: "She/Hers",
    ethnicity: ['Chinese', 'White'], major: 'Intended Cognitive Science', dsp: false, transfer: false, term: "2",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")

  #Tutors have 7 digits in their SID
  #hopefully this BerkeleyClass shit will be gone soon too...
  Tutor.create( #user 4
    first_name: "Tutor", last_name: "One", email: "tr1@berkeley.edu", gender: "Male", pronoun: "He/His",
    ethnicity: ['Chinese'], major: 'Declared Computer Science', dsp: false, transfer: true, term: "4",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
  Tutor.create(
    first_name: "Tutor", last_name: "Two", email: "tr2@berkeley.edu", gender: "Female", pronoun: "She/Hers",
    ethnicity: ['White'], major: "Intended Data Science", dsp: true, transfer: false, term: "3",
    password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
  Tutor.create(
    first_name: "Tutor", last_name: "Three", email: "tr3@berkeley.edu", gender: "Non-Binary", pronoun: "They/Theirs",
    ethnicity: ['Black'], major: "Intended Other", dsp: true, transfer: true, term: "6",
    password: Admin.general_seed_password, :password_confirmation => Admin.general_seed_password, :confirmed_at => "2021-05-07 05:07:48")


  #3 past meetings that have occurred between tr2 and all three tts
  Request.create(:tutee_id=>"1",:course=>"CS61A",:meeting_length=>2,:subject=>"seeded request tutee 1 - 1", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Meeting.create(:tutor_id=>"5", :request_id=>"1", is_done: true)
  Evaluation.create(meeting_id: "1", :took_place=>true, :status=>"Complete", :hours=>2)

  Request.create(:tutee_id=>"2",:course=>"CS88",:meeting_length=>2,:subject=>"seeded request tutee 2 - 1", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Meeting.create(:tutor_id=>"5", :request_id=>"2", is_done: true)
  Evaluation.create(meeting_id: "2", :took_place=>true, :status=>"Complete", :hours=>5)

  Request.create(:tutee_id=>"3",:course=>"CS70",:meeting_length=>2,:subject=>"seeded request tutee 3 - 1", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Meeting.create(:tutor_id=>"5", :request_id=>"3", is_done: true)
  Evaluation.create(meeting_id: "3", :took_place=>true, :status=>"Complete", :hours=>2)

  #One past meeting occurred between tr1 and tt1
  Request.create(:tutee_id=>"1",:course=>"CS10",:meeting_length=>2,:subject=>"seeded request tutee 1 - 2", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Meeting.create(:tutor_id=>"4", :request_id=>"4", is_done: true)
  Evaluation.create(meeting_id: "4", :took_place=>true, :status=>"Complete", :hours=>2)

  #tt1 requests 61A tutoring
  Request.create(:tutee_id=>"1",:course=>"CS61B",:meeting_length=>1,:subject=>"seeded request tutee 1 - 3", :status=>"open", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")

  #Meeting proposed for tt2 by tr2
  Request.create(:tutee_id=>"2",:course=>"CS61A",:meeting_length=>1,:subject=>"seeded request tutee 2 - 2", :status=>"matched", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
  Meeting.create(:tutor_id=>"5", :request_id=>"6")
end
