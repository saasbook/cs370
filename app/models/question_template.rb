class QuestionTemplate < ApplicationRecord
  has_many :question

  def self.num_active_questions
    int result = 0
    QuestionTemplate.all do |qt|
      if qt.order > 0 #negative values of order indicate inactive questions
        result += 1
      end
    end
    return result
  end
end
