class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by_id(session[:current_user_id])
    #tutors get their own dashboard, but also an option to switch between tutee/tutor views
    if @user.tutee?
      show_tutee_dashboard
    else
      show_tutor_dashboard
    end
  end

  private
  def show_tutee_dashboard
    @request  = @user&.requests&.last
    @meeting = @request&.meeting
    @evaluation = @meeting&.evaluation
    @meeting_time = [["1 hour",1], ["1.5 hours",1.5], ["2 hours",2]]
    if @request.nil? or @evaluation&.complete? #new account or no active request (all previous fulfilled/closed by admin)
      if !Admin.signups_allowed?
        @status_arr = ['closed','Tutoring signups are closed at this time, please keep an eye on announcements for when they will reopen!']
      else
        @status_arr = ['none','No request pending.']
      end
    elsif @request&.closed_by_admin?
      @status_arr = ['none','Your request was closed by admin, please submit a new request.']
    elsif @request.open?                                 #most recent request is still open
      @status_arr = ['open','Request submitted']
    elsif @request.matched?                              #matched request
      if @meeting.unscheduled?                           #waiting for schedule
        @status_arr = ['unscheduled','Request matched! Please check your email to confirm a meeting time with your tutor.']
      elsif @meeting.scheduled?                          #scheduled waiting for finished
        @status_arr = ['scheduled','Meeting time confirmed! Please be on time and communicate with your tutor if anything comes up.']
      elsif @meeting.finished? and @evaluation.pending?  #meeting finished, evaluation must be pending and must exist, else it would have been caught by .complete? above
        @status_arr = ['finished','Evaluation pending. You must complete the evaluation before making another request.']
        @question_partials = []
        @evaluation.question.each do |q|
          question_partial = create_question_partial q
          if question_partial != "invalid"
            @question_partials << question_partial
          end
        end
      end
    end
    @has_priority = Admin.priority_list_contains? @user
    @course_array = Admin.course_list
    @previous_requests = Request.where(tutee_id: @user.id)
  end

  def show_tutor_dashboard
    @meetings = Meeting.where("tutor_id = ? AND status != 'finished'", @user.id)
    @previous_meetings = Meeting.where("tutor_id = ? AND status = 'finished'", @user.id)
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
end
