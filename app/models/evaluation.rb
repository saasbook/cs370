class Evaluation < ApplicationRecord
  include Friendlyable
  has_one :meeting
  has_one :request, through: :meeting
  has_one :tutor, through: :meeting
  has_one :tutee, through: :request

  validates :topics, presence: true, on: :update, :if => :took_place
  validates :hours, presence: true, inclusion: {in: %w(1 1.5 2 2.5 3 3.5 4 4.5 5)}, on: :update, :if => :took_place
  validates :positive, presence: true, on: :update, :if => :took_place
  validates :best, presence: true, on: :update, :if => :took_place
  validates :feedback, presence: true, on: :update, :if => :took_place
  validates :knowledgeable, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :helpful, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :clarity, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :pacing, presence: true, inclusion: {in: %w(1 2 3 4 5), message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :final_comments, presence: true, on: :update, :if => :took_place
  validates :status, presence: true, inclusion: { in: %w(Pending Complete), message: "Must be valid status"}, on: :update, :if => :took_place
end
