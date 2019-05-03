class Meeting < ApplicationRecord
  belongs_to :tutor
  belongs_to :request
  belongs_to :evaluation
end
