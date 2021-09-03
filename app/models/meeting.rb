class Meeting < ApplicationRecord
  has_one :evaluation

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
