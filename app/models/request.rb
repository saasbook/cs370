class Request < ApplicationRecord
  belongs_to :tutee
  has_one :meeting
  has_one :tutor, through: :meeting
  has_one :evaluation, through: :meeting

  def self.to_csv
	attributes = Request.attribute_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |request|
        csv << request.attributes.values
      end
    end
  end

  def matched?
    !Meeting.where(:request_id => id).first.nil?
  end
end
