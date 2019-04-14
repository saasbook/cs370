FactoryBot.define do
  factory :tutor do
    id {1}
  end

  factory :request do
    tutee_id {create(:tutee).id}
    course_id {create(:course).id}
    subject {"tree"}
   end

  factory :meeting do
    tutor
    request
  end
end
