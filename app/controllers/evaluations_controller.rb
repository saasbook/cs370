class EvaluationsController < ApplicationController
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :meeting)
  end
  def new
  end

  def create
  end
end
