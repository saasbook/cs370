class Evaluation < ApplicationRecord
  has_one :meeting
  has_one :tutor, through: :meeting
end
