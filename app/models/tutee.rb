class Tutee < ApplicationRecord
  has_many :requests
  has_many :courses, through: :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests
  scope :pending_evaluations, lambda { |student|
      Tutee.joins(:requests => {:meeting => evaluation}).where(tutee.id => student, evaluation.status => 'pending').uniq}
end
