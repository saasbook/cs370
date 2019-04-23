class EvaluationsController < ApplicationController
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :meeting)
  end
  def new
    @tutee = Tutee.find_by_id(params[:tutee_id])
    # @eval = Evaluation.new()
    # redirect_to evaluations_new_path
  end

  def create
    # @tutee = Tutee.find_by_id(params[:id])

  end
end
