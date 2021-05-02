class EvaluationsController < ApplicationController
  before_action :check_student_logged_in, :except => [:public_edit, :public_show]
  layout 'tutee_layout', :only => [:edit, :index]
  def evaluation_params
    params.require(:evaluation).permit(:topics, :hours, :positive, :best, :feedback, :knowledgeable, :helpful, :clarity, :pacing, :final_comments, :took_place, :status, :hash_id)
  end

  def edit
    @tutee = Tutee.find params[:tutee_id]
    @evaluation = Evaluation.friendly.find params[:id]
    @meeting = Meeting.where("evaluation_id = ?", @evaluation.id).first
    if @meeting.nil? or @meeting.set_time.nil?
      @is_eval_available = false
    else
      @is_eval_available = @meeting.set_time < Time.now #4/9/21 TODO: needs to be changed for when Tutor marks Meeting as occurred
    end

    @question_partials = []
    @evaluation.question.each do |q|
      question_partial = create_question_partial q
      if question_partial != "invalid"
        @question_partials << question_partial
      end
    end
  end

  def create_question_partial question
    #check to make sure the source QT hasn't changed since this Question was created
    source_qt = QuestionTemplate.find(question.question_template_id)
    if source_qt.updated_at > question.created_at
      #QT has changed, ignore this question
      return "invalid"
    else
      #Add valid question partial to render with corresponding parameters
      return render_to_string(partial: "questions/question_type_#{source_qt.question_type}", locals: {question: question, prompt: source_qt.prompt, details: source_qt.details})
    end
  end

  def update
    @evaluation = Evaluation.find_by_hash_id params[:id]
    @evaluation.update(evaluation_params)
    puts evaluation_params

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
