FactoryBot.define do

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
