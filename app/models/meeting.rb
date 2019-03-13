class Meeting < ApplicationRecord
  belongs_to :tutor
  belongs_to :request
end
