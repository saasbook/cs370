class Evaluation < ApplicationRecord
  has_one :meeting
  has_one :request, through: :meeting
  has_one :tutor, through: :meeting
  has_one :tutee, through: :request
  validates :topics, presence: true
  validates :hours, presence: true, inclusion: {in: %w(1 1.5 2 2.5 3 3.5 4 4.5 5)}
  validates :positive, presence: true
  validates :best, presence: true
  validates :feedback, presence: true
  validates :knowledgeable, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}
  validates :helpful, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}
  validates :clarity, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}
  validates :pacing, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}
  validates :final_comments, presence: true
  validates :status, presence: true, inclusion: { in: %w(Pending Complete), message: "Must be valid status"}
end
