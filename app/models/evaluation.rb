class Evaluation < ApplicationRecord
  include Friendlyable
  has_one :meeting
  has_one :request, through: :meeting
  has_one :tutor, through: :meeting
  has_one :tutee, through: :request
  validates :took_place, inclusion: {in: %w(true false), message: 'Cannot be blank'}
  validates :topics, presence: true, on: :update, :if => :took_place
  validates :hours, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}, on: :update, :if => :took_place.equal?('true')
  validates :positive, presence: true, on: :update, :if => :took_place.equal?('true')
  validates :best, presence: true, on: :update, :if => :took_place.equal?('true')
  validates :feedback, presence: true, on: :update, :if => :took_place.equal?('true')
  validates :knowledgeable, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place.equal?('true')
  validates :helpful, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place.equal?('true')
  validates :clarity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place.equal?('true')
  validates :pacing, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place.equal?('true')
  validates :final_comments, presence: true, on: :update, :if => :took_place.equal?('true')
  validates :status, presence: true, inclusion: { in: %w(Pending Complete), message: "Must be valid status"}, on: :update, :if => :took_place.equal?('true')
end
