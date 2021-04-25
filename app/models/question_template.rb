class QuestionTemplate < ApplicationRecord
  has_many :question

  def self.ordered_list_of_question_templates
    result = []
    num_active = QuestionTemplate.all.count
    num_active.times do |x|
      result.push(QuestionTemplate.find_by!(order: x+1))
    end
    return result
  end
end
