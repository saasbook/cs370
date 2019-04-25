class Request < ApplicationRecord
  belongs_to :tutee
  belongs_to :course
  has_one :meeting
end
