FactoryBot.define do
  factory :tutor do
    # id {1}
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
