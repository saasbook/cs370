class Tutee < ApplicationRecord
  has_many :requests
  has_many :courses, through: :requests
  scope :pending_evaluations, lambda { |student|
      Evaluation.find_by_id(Tutee.joins(:requests, :meetings, :evaluation).where(tutee.id: student).where(evaluation.status: 'pending').uniq)}

  end
end
