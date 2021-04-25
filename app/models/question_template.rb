class QuestionTemplate < ApplicationRecord
  has_many :question

  def self.num_active_questions
    result = 0
    QuestionTemplate.all.each do |qt|
      if qt.order > 0 #negative values of order indicate inactive questions
        result += 1
      end
    end
    return result
  end

  def self.ordered_list_of_question_templates
    result = []
    puts 'hi'
    num_active = QuestionTemplate.num_active_questions
    num_active.times do |x|
      result.push(QuestionTemplate.find_by!(order: x+1))
    end
    return result
  end
end
