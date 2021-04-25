class QuestionTemplatesController < ApplicationController
  def batch_update
    flash[:notice] = @question_templates.First.prompt
    redirect_to admin_update_question_templates_path
  end
end
