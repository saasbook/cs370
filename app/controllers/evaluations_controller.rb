class EvaluationsController < ApplicationController
  layout 'tutee_layout', :only => [:index, :edit, :show]
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :took_place, :status, :hash_id)
  end
  def new
    @tutee = Tutee.find params[:tutee_id]
  end

  def create
  end

  def edit
    @tutee = Tutee.find params[:tutee_id]
    @evaluation = Evaluation.friendly.find params[:id]
  end

  def update
    @evaluation = Evaluation.find_by_hash_id params[:id]
    @evaluation.update!(evaluation_params)

    if params.has_key?(:tutee_id)
      @tutee = Tutee.find params[:tutee_id]
      flash[:message] = 'Evaluation form submitted sucessfully!'
      redirect_to tutee_evaluations_path(@tutee)
    else
      flash[:message] = 'Evaluation form submitted sucessfully!'
      redirect_to evaluation_path(@evaluation)
    end
  end



  def index
    @tutee = Tutee.find params[:tutee_id]
    @evaluations = @tutee.evaluations.where(:status => 'Pending')
  end

  def pending_evaluations
    @tutee = Tutee.find params[:id]
    @evaluations = @tutee.evaluations
  end

  def show
    @evaluation = Evaluation.friendly.find params[:id]
  end

  def public_edit
     @evaluation = Evaluation.find_by_hash_id params[:id]
  end

  def public_show
    @evaluation = Evaluation.find_by_hash_id params[:id]

  end
end
