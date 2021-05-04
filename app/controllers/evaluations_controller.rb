class EvaluationsController < ApplicationController
  before_action :check_student_logged_in, :except => [:view_responses]
  layout 'tutee_layout'

  def edit
    @tutee = Tutee.find params[:tutee_id]
    @evaluation = Evaluation.friendly.find params[:id]
    @meeting = Meeting.where("evaluation_id = ?", @evaluation.id).first
    if not @meeting.nil? and not @meeting.set_time.nil?
      @is_eval_available = ((@meeting.set_time < Time.now) or @meeting.is_done)
    else
      @is_eval_available = false
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
      return render_to_string(partial: "questions/question_type_#{source_qt.question_type}", locals: {id: question.id, prompt: source_qt.prompt, details: source_qt.details, is_mandatory: !source_qt.is_optional})
    end
  end

  def view_responses
    meeting = Meeting.find(params['meeting_id'])
    evaluation = meeting.evaluation
    return render json:{partial: render_to_string(partial: "evaluations/question_responses", locals: {evaluation: evaluation, user: 'tutor'})}
  end

  def update
    @evaluation = Evaluation.friendly.find params[:id]
    puts "Evaluation#update Entered"
    puts @evaluation
    took_place = (params['hours'].to_d > 0)
    @evaluation.update(took_place: took_place, course: params['course'], hours: params['hours'], status: "Complete")
    #in case the tutor hasn't marked it as done yet, tutee submitting an evaluation will.
    @evaluation.meeting.update(is_done: true)
    params.keys.each do |k|
      if k.include?('response_')
        qid = k.split('_')[1]
        res = took_place ? params[k] : "N/A"
        Question.find(qid).update!(response: res)
      end
    end
    redirect_to tutee_path(id: @evaluation.tutee.id)
  end

  #Evaluation tab on Tutee page
  def index
    @tutee = Tutee.find params[:tutee_id]
    @evaluations = @tutee.evaluations.where(:status => 'Pending')
  end

  #When you click on "Complete" inside of Tutee History page
  def show
    @evaluation = Evaluation.friendly.find params[:id]
    @tutee = Tutee.find params[:tutee_id]
  end
end
