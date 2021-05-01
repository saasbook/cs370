FactoryBot.define do
  factory :admin do
    password { "111111" }
    statistics_semester { "MyString" }
    current_semester { "MyString" }
    tutor_types {"CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)"}
    priority_list {[133742069]}
  end
end
