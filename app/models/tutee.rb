class Tutee < ApplicationRecord
  has_many :requests
  has_many :tutors, through: :requests
  validates_uniqueness_of :email, :message => "Email already exists"
end
