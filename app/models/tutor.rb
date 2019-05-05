class Tutor < ApplicationRecord
	has_one :berkeley_class
	has_many :meetings
	has_many :requests, through: :meetings
	has_many :tutees, through: :requests
	has_many :evaluations, through: :meetings
	validates :type_of_tutor, presence: true
	validates :grade_level, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, format: {with: /\A[\w+\-.]+@berkeley.edu/, message:"Please give a valid Berkeley email address "}, :on => :create
end
