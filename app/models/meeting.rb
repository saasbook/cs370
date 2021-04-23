class Meeting < ApplicationRecord
  belongs_to :tutor
  belongs_to :request
  belongs_to :evaluation
  has_one :tutee

  def self.to_csv
    attributes = Meeting.attribute_names

      CSV.generate(headers: true) do |csv|
        csv << attributes.first(13)

        all.each do |meeting|
          csv << meeting.attributes.values.first(13)
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
