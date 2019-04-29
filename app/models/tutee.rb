class Tutee < ApplicationRecord
  has_many :requests
  has_many :courses, through: :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests
end
