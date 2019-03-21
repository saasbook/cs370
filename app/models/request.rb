class Request < ApplicationRecord
  belongs_to :tutee
  belongs_to :course
end
