class Meeting < ApplicationRecord
  belongs_to :tutor
  belongs_to :request
  belongs_to :evaluation, optional: true
  has_one :tutee

  def self.to_csv
    attributes = Meeting.attribute_names

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |meeting|
          csv << meeting.attributes.values
        end
      end
  end

  # def isExpired
  # 	if self.set_time.nil?
  # 		return false
  # 	end
	# return self.set_time < Time.now
  # end
end
