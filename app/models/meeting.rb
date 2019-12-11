class Meeting < ApplicationRecord
  belongs_to :tutor
  belongs_to :request
  belongs_to :evaluation
  has_one :tutee

  def isExpired
  	if self.setTime.nil?
  		return true
  	end
	return self.setTime < Time.now
  end
end
