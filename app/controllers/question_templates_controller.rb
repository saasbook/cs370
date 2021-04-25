class QuestionTemplatesController < ApplicationController
  def batch_update
    flash[:notice] = params.keys
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
      QuestionTemplate.find(id).update!(order: order+1)
    end
    redirect_to admin_update_question_templates_path
  end
end
