class EvaluationsController < ApplicationController
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :meeting)
  end
  def new
    @tutee = Tutee.find params[:tutee_id]
  end

  def create
    # @tutee = Tutee.find_by_id(params[:id])

  end
  def edit
    @tutee = Tutee.find params[:tutee_id]
    @evaluation = Evaluation.find params[:evaluation_id]
  end
end
