class QuestionTemplate < ApplicationRecord
  has_many :question

  def self.ordered_list_of_question_templates
    result = []
    QuestionTemplate.all.count.times do |x|
      result.push(QuestionTemplate.find_by!(order: x+1))
    end
    return result
  end
end
