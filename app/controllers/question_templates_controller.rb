class QuestionTemplatesController < ApplicationController
  def batch_update
    flash[:success] = "Updated Question Templates and Layout Successfully"

    new_ordering = []
    params.keys.each do |k|
      if k.include?('qt')
        #third index is always the qt id value, a la qt_#{qt.index}_etcetc
        new_ordering.push(k[3])
      end
    end
    
    new_ordering = new_ordering.uniq
    new_ordering.each_with_index do |id, order|
      qt = QuestionTemplate.find(id)
      qt.update!(order: order+1)
      qt.update!(prompt: params["qt_#{id}_prompt"])
      qt.update!(is_optional: params["qt_#{id}_is_optional"])
      qt.update!(question_type: params["qt_#{id}_question_type"])
      qt.update!(is_active: params["qt_#{id}_is_active"])
    end

    redirect_to admin_update_question_templates_path
  end
end
