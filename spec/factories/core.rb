FactoryBot.define do

  factory :tutor do
    # id {1}
    type_of_tutor {"CSM"}
    term {"8"}
    first_name {"Alvin"}
    last_name {"NGUYEN"}
    email {"alvinnguyen@berkeley.edu"}
  end

  factory :request do
    tutee {create(:tutee)}
    course {create(:course)}
    # subject {"tree"}
   end

  factory :meeting do
    tutor
    request
  end
end
