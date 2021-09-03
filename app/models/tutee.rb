class Tutee < User
  has_many :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests
end
