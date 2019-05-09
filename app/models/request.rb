class Request < ApplicationRecord
  belongs_to :tutee
  belongs_to :course
  has_one :meeting
  has_one :tutor, through: :meeting
  has_one :evaluation, through: :meeting
end
