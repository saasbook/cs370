FactoryBot.define do
  factory :tutor
  factory :request

  factory :meeting do
    tutor
    request
  end
end