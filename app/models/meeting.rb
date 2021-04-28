class Meeting < ApplicationRecord
  belongs_to :tutor
  belongs_to :request
  belongs_to :evaluation
  has_one :tutee

  # def isExpired
  # 	if self.set_time.nil?
  # 		return false
  # 	end
	# return self.set_time < Time.now
  # end
end
