class Course < ApplicationRecord
  has_many :requests
  class<<self
    def current_semester
      return "Spring2019"
    end
  end
end
