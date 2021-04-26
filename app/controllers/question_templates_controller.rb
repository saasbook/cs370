class QuestionTemplatesController < ApplicationController
  def batch_update
    new_ordering = []
    params.keys.each do |k|
      if k.include?('qt')
        #second split by _ index is always the qt id value, a la qt_#{qt.index}_etcetc
        index = k.split('_')[1]
        new_ordering.push(index)
        if k.include?('details')
          detail_key = k.split('details_')[1]
          qt = QuestionTemplate.find(index)
          curr_details = qt.details
          curr_details[detail_key] = params[k]
          qt.update!(details: curr_details)
        end
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
      qt.update!(is_admin_only: params["qt_#{id}_is_admin_only"])
    end
    flash[:success] = "Updated Question Templates and Layout Successfully"
    redirect_to admin_update_question_templates_path
  end

  def get_num_prompts
    return render json: {:num_prompts => QuestionTemplate.all.count}
  end

  def get_details
    qt = QuestionTemplate.find(params['id'])
    case params["selection"]
    when 'text'
      return render json: {result: render_to_string(partial:'admins/question_type_text', locals: {id: qt.id, details: qt.details})}
    when 'scale'
      return render json: {result: render_to_string(partial:'admins/question_type_scale', locals: {id: qt.id, details: qt.details})}
    when 'dropdown'
      return render json: {result: render_to_string(partial:'admins/question_type_dropdown', locals: {id: qt.id, details: qt.details})}
    end
  end
end
