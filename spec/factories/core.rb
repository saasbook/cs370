FactoryBot.define do
  factory :tutor do
    id {1}
    type_of_tutor {"CSM"}
    grade_level {"SENIOR"}
    first_name {"Alvin"}
    last_name {"NGUYEN"}
    email {"alvinnguyen@berkeley.edu"}
  end

  factory :request do
    id {1}
    tutee {create(:tutee)}
    course {create(:course)}
    # subject {"tree"}
   end

  factory :meeting do
    tutor
    request
  end
end
