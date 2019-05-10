class EvaluationsController < ApplicationController
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :took_place, :status, :hash_id)
  end
  def new
    @tutee = Tutee.find params[:tutee_id]
  end

  def create
    # @tutee = Tutee.find_by_id(params[:id])

  end

  def edit
    @tutee = Tutee.find params[:tutee_id]
    @evaluation = Evaluation.friendly.find params[:id]
  end

  def update
    @evaluation = Evaluation.find_by_hash_id params[:id]
    p params[:hours]
    p params[:knowledgeable]
    @evaluation.update!(evaluation_params)

    if params.has_key?(:tutee_id)
      @tutee = Tutee.find params[:tutee_id]
      redirect_to tutee_evaluations_path(@tutee)
    else
      flash[:message] = 'Evaluation form submitted sucessfully!'
    end
  end

  # def update
  #   @tutee = Tutee.find params[:id]
  #   tutee_params[:email] = tutee_params[:email].downcase!
  #
  #   if validInputs? tutee_params
  #     @tutee.update!(tutee_params)
  #     flash[:message] = "Information was successfully updated."
  #     redirect_to tutee_path(@tutee)
  #   else
  #     flash[:message] = "Invalid Inputs"
  #     redirect_to edit_tutee_path(@tutee)
  #   end
  # end



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
