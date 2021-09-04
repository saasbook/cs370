class Tutee < User
  has_many :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
