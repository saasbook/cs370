class Evaluation < ApplicationRecord
  has_one :meeting
  has_one :request, through: :meeting
  has_one :tutor, through: :meeting
  has_one :tutee, through: :request
end
