class Course < ApplicationRecord
  has_many :requests
  class<<self
    def current_semester
      return Admin.current_semester
    end
  end
end
