FactoryBot.define do
  factory :admin do
    password { Admin.general_seed_password }
    tutor_types {"CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)"}
    course_list {["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV"]}
    priority_list {[110000,111000,112000,113000,113100,113110,113111]}
  end
end
