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
  validates :feedback, presence: true, on: :update, :if => :took_place
  validates :knowledgeable, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :helpful, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :clarity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :pacing, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Must be valid rating integer"}, on: :update, :if => :took_place
  validates :final_comments, presence: true, on: :update, :if => :took_place
  validates :status, presence: true, inclusion: { in: %w(Pending Complete), message: "Must be valid status"}, on: :update, :if => :took_place

  def self.total_hours
    self.where(:took_place => true).where(:status => "Complete").sum(:hours)
  end

  def self.hours_ethnicity ethnicity
    return Tutee.where(ethnicity: ethnicity).joins(:evaluations).where("evaluations.took_place" => true).where("evaluations.status" => "Complete").sum(:hours)
  end

  def self.hours_gender gender
    return Tutee.where(gender: gender).joins(:evaluations).where("evaluations.took_place" => true).where("evaluations.status" => "Complete").sum(:hours)
  end

  def self.hours_demographic_to_csv
    ethnicities = ['Asian','Black/African','Caucasian', 'Hispanic/Latinx', 'Native American',
      'Pacific Islander', 'Mixed', 'Other']
    genders = ['Male', 'Female', 'Non-Binary']

    attributes = ["Ethnicity/Gender", "Total Hours"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      ethnicities.each do |ethnicity|
        csv << [ethnicity, self.hours_ethnicity(ethnicity)]
      end

      genders.each do |gender|
        csv << [gender, self.hours_gender(gender)]
      end

      csv << ["Total Hours", Evaluation.total_hours]
    end
  end

  def self.hours_course course
    return Request.where(:course => course).joins(:meeting).joins(:evaluation).where("evaluations.took_place" => true).where("evaluations.status" => "Complete").sum(:hours)
  end

  def self.hours_course_to_csv
    courses = Course.where(:active => true)

    attributes = ["Ethnicity/Gender", "Total Hours"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      courses.each do |course|
        csv << [course.name, self.hours_course(course)]
      end

      csv << ["Total Hours", Evaluation.total_hours]
    end
  end


end
