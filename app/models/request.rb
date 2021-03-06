class Request < ApplicationRecord
  belongs_to :tutee
  has_one :meeting
  has_one :tutor, through: :meeting
  has_one :evaluation, through: :meeting

  validates :meeting_length, presence: {message: "Meeting length cannot be left empty"}

  def self.to_csv
	attributes = Request.attribute_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |request|
        csv << request.attributes.values
      end
    end
  end

  def self.get_open_requests_by_course course
    Request.where(course: course, status: "open")
  end

  def matched?
    !Meeting.where(:request_id => id).first.nil?
  end
end
