class Request < ApplicationRecord
  belongs_to :tutee
  belongs_to :course
  has_one :meeting
  has_one :tutor, through: :meeting
  has_one :evaluation, through: :meeting

  def get_class
    Course.find_by_id(course_id).name
  end
end
