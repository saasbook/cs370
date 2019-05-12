class EvaluationsController < ApplicationController
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :took_place, :status, :hash_id)
  end

  def create
  end

  def edit
    @tutee = Tutee.find params[:tutee_id]
    @evaluation = Evaluation.friendly.find params[:id]
  end

  def update
    @evaluation = Evaluation.find_by_hash_id params[:id]
    @evaluation.update(evaluation_params)

    if params.has_key?(:tutee_id)
      _update_params_has_key_helper(:tutee_id, @evaluation)
    else
      _update_params_has_no_key_helper(@evaluation)
    end
  end

  def _update_params_has_key_helper(tutee_id, eval)
    @tutee = Tutee.find params[:tutee_id]
    if eval.save
      flash[:message] = 'Evaluation form submitted sucessfully!'
      redirect_to tutee_evaluations_path(@tutee)
    else
      flash[:notice] = 'Evaluation form submitted unsucessfully!'
      redirect_to edit_tutee_evaluation_path(@tutee)
    end 
  end

  def _update_params_has_no_key_helper(eval)
    if eval.save
      flash[:message] = 'Evaluation form submitted sucessfully!'
      redirect_to evaluation_path(eval)
    else
      flash[:notice] = 'Evaluation form submitted unsucessfully!'
      redirect_to edit_evaluation_path(eval)
    end
  end

  def index
    @tutee = Tutee.find params[:tutee_id]
    @evaluations = @tutee.evaluations.where(:status => 'Pending')
  end

  def show
    @evaluation = Evaluation.find_by_id params[:id]
  end

  def public_edit
     @evaluation = Evaluation.find_by_hash_id params[:id]
  end

  def public_show
    @evaluation = Evaluation.find_by_hash_id params[:id]

  end
end
