class Evaluation < ApplicationRecord
  include Friendlyable
  has_one :meeting
  has_one :request, through: :meeting
  has_one :tutor, through: :meeting
  has_one :tutee, through: :request

  validates :took_place, inclusion: { in: [ true, false ] }, on: :update
  validates :topics, presence: true, on: :update, :if => :took_place
  validates :hours, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}, on: :update, :if => :took_place
  validates :positive, presence: true, on: :update, :if => :took_place
  validates :best, presence: true, on: :update, :if => :took_place
  validates :feedback, presence: true, on: :update, :if => :took_place.equal?('true')
  validates :knowledgeable, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :helpful, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :clarity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :pacing, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :final_comments, presence: true, on: :update, :if => :took_place
  validates :status, presence: true, inclusion: { in: %w(Pending Complete), message: "Must be valid status"}, on: :update, :if => :took_place
end
