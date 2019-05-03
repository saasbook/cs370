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



	def self.total_hours_helper tutor
		@all_evals = tutor.evaluations
		return @all_evals.sum(:hours)
	end

	def self.hours_this_week_helper tutor
		return tutor.evaluations.where(created_at: (Time.now - 1.week)..Time.now).sum(:hours)
	end

	def self.average_hours_helper tutor
		all_evals = tutor.evaluations
		if all_evals.empty?
			return "Not Available"
		end

		earliest_timestamp = all_evals.order(:created_at).first.created_at
		latest_timestamp = all_evals.order(:created_at).last.created_at
		if !earliest_timestamp.nil? and !latest_timestamp.nil?
			difference = latest_timestamp - earliest_timestamp
			if difference == 0
				return total_hours_helper(tutor)
			end
			total_weeks = (difference / 86400)
			return total_hours_helper(tutor)/total_weeks
		end

		return "Not Available"
	end
end
