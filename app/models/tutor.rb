class Tutor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :validatable, :recoverable, :rememberable, stretches: 12
	has_one :berkeley_class
	has_many :meetings
	has_many :requests, through: :meetings
	has_many :tutees, through: :requests
	has_many :evaluations, through: :meetings
	validates :type_of_tutor, presence: true
	validates :term, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, format: {with: /\A[\w+\-.]+@berkeley.edu/, message:"Please give a valid Berkeley email address "}, :on => :create
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }

	def self.total_hours_helper tutor
		@all_evals = tutor.evaluations
		return @all_evals.sum(:hours)
	end

	def self.hours_this_week_helper tutor
		return tutor.evaluations.where(created_at: Time.now.beginning_of_week.strftime("%Y-%m-%d")..Time.now).sum(:hours)
	end

	def self.average_hours_helper tutor
		all_evals = tutor.evaluations
		if all_evals.empty?
			return "Not Available"
		end
		earliest_timestamp = all_evals.order(:created_at).first.created_at
		latest_timestamp = all_evals.order(:created_at).last.created_at
		if !earliest_timestamp.nil? and !latest_timestamp.nil?
			puts 'latest_timestamp: ' + latest_timestamp.to_s
			puts 'earliest_timestamp: ' + earliest_timestamp.to_s
			difference = latest_timestamp - earliest_timestamp
			if difference == 0
				return total_hours_helper(tutor)
			end
			total_days = (difference / 86400)
      		total_weeks = total_days / 7
			return total_hours_helper(tutor)/total_weeks
		end
	end

	def self.hours_to_csv
		attributes = ["Tutor Email", "Tutor Name", "Total Hours"]

	    CSV.generate(headers: true) do |csv|
	      csv << attributes

	      all.each do |tutor|
	        csv << [tutor.email, tutor.name, tutor.hours]
	      end
	      csv << ["Total Hours", "", Evaluation.total_hours]
	    end
	end

	def self.ratings_to_csv
		attributes = ["Tutor Email", "Tutor Name","How knowledgeable was your tutor?",
			"How supportive or helpful was your tutor?", "How clear were the tutor's explanations?",
			"How was the pacing?"]

	    CSV.generate(headers: true) do |csv|
	      csv << attributes

	      all.each do |tutor|
	      	ratings = tutor.average_ratings
	        csv << [tutor.email, tutor.name, ratings[:knowledgeable], ratings[:helpful],
	        	ratings[:clarity], ratings[:pacing]]
	      end
	      ratings = self.average_ratings
	      csv << ["Average Ratings", "", ratings[:knowledgeable], ratings[:helpful],
	        	ratings[:clarity], ratings[:pacing]]
	    end
	end

	# average ratings of all tutors
	def self.average_ratings
		average_ratings = {:knowledgeable => 0.0, :helpful => 0.0,
			:clarity => 0.0, :pacing => 0.0}

		# non_zero accounts for tutors who haven't been rated yet so they won't bring down the average
		non_zero = 0
		all.each do |tutor|
            ratings = tutor.average_ratings
			average_ratings[:knowledgeable] += ratings[:knowledgeable]
			average_ratings[:helpful] += ratings[:helpful]
			average_ratings[:clarity] += ratings[:clarity]
			average_ratings[:pacing] += ratings[:pacing]
			if ratings[:knowledgeable] != 0
				non_zero += 1
			end
		end

		if non_zero != 0
			average_ratings[:knowledgeable] = (average_ratings[:knowledgeable] / non_zero).round(2)
			average_ratings[:helpful] = (average_ratings[:helpful] / non_zero).round(2)
			average_ratings[:clarity] = (average_ratings[:clarity] / non_zero).round(2)
			average_ratings[:pacing] = (average_ratings[:pacing] / non_zero).round(2)
		end

		return average_ratings
	end

	def hours
		evaluations.where(:took_place => true).where(:status => "Complete").sum(:hours)
	end

	def name
		"#{first_name} #{last_name}"
	end

	def average_ratings
		evals = evaluations.where(:took_place => true).where(:status => "Complete")
		knowledgeable = 0.0
		helpful = 0.0
		clarity = 0.0
		pacing = 0.0

		num = evals.count.to_f
		if num > 0
			knowledgeable = (evals.sum(:knowledgeable) / num).round(2)
			helpful = (evals.sum(:helpful) / num).round(2)
			clarity = (evals.sum(:clarity) / num).round(2)
			pacing = (evals.sum(:pacing) / num).round(2)
		end

		return {:knowledgeable => knowledgeable, :helpful => helpful,
			:clarity => clarity, :pacing => pacing}
	end
end
