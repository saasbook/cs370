class Tutee < ApplicationRecord
  has_many :requests
  has_many :tutors, through: :requests
end
