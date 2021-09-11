require 'date'
class TutorsController < ApplicationController
  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all
  end

  def finish_meeting
    @meeting = Meeting.find_by_id(params['finish-meeting-hidden-field'])
    tid = session[:current_user_id]
    sid = @meeting.tutee.id

    begin
      TutorMailer.meeting_complete_notice(tid, sid).deliver_now
    rescue StandardError
      flash[:notice] = "An error occured when sending out emails. Meeting was not marked as complete, please contact an administrator if this error persists."
    else
      flash[:success] = "Your meeting was successfully finished."
      @eval = Evaluation.create(meeting_id: @meeting.id)
      QuestionTemplate.ordered_list_of_question_templates.each do |qt|
        if qt.is_active
          Question.create(evaluation_id: @eval.id, question_template_id: qt.id, prompt: qt.prompt, is_admin_only: qt.is_admin_only)
        end
      end
      @meeting.update!(is_done: true)
    end

    redirect_back(fallback_location:"/")
  end

  def delete_meeting
    meeting = Meeting.find_by_id(params['delete-meeting-hidden-field'])
    #open request for tutee and for other tutors
    meeting.request.update(status: "open")
    meeting.destroy()

    flash[:success] = "Your meeting was successfully cancelled."
    redirect_back(fallback_location:"/")
  end

  def confirm_meeting
    @meeting = Meeting.find(params["meeting_id"])
    @tutor_id = @meeting.tutor.id
    @tutee_id = @meeting.tutee.id
    @request_id = @meeting.request.id
    @time = Time.strptime(params["meeting_date"] + params["meeting_time"], "%Y-%m-%d%H:%M")
    @loc = params[:meeting_location]

    tutor_message = "Hi, your meeting has been confirmed for " + @time.strftime("%A, %b %d at %l:%M %p") + " at " + @loc + "."

    begin
      TutorMailer.meeting_confirmation(@tutor_id, @tutee_id, tutor_message, @request_id).deliver_now
    rescue StandardError
      flash[:notice] = "An error occured when sending out confirmation emails."
    else
      flash[:success] = "Successfully confirmed meeting details!"
      @meeting.update(set_time: @time, set_location: @loc, is_scheduled: true);
    end
    redirect_back(fallback_location:"/")
  end

  def match
    tutor_id = session[:current_user_id]
    tutee_email = params[:tutee_email]
    tutee_id = Tutee.find_by_email(tutee_email).id
    request_id = params[:request_id]
    tutor_message = params[:tutor_message]
    begin
      TutorMailer.invite_student(tutor_id, tutee_id, request_id, tutor_message).deliver_now
    rescue StandardError
      flash[:notice] = "An error occured when sending out emails."
    else
      flash[:success] = "Successfully matched!"
      Meeting.create!(tutor_id: tutor_id, request_id: request_id, is_scheduled:false)
      Request.find(request_id).update(status: 'matched')
    end
    redirect_back(fallback_location:"/")
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find_by_id(params[:id])
    @meetings = Meeting.where("tutor_id = ? AND is_done = FALSE", params[:id])
    @previous_meetings = Meeting.where("tutor_id = ? AND is_done = TRUE", params[:id])
  end

  # GET /tutors/new
  def new
    @tutor = Tutor.new
  end

  # GET /tutors/1/edit
  def edit
  end

  def total_hours
    @tutor= Tutor.find(params[:id])
    return Tutor.total_hours_helper(@tutor)
  end
  helper_method :total_hours


  def hours_this_week
    @tutor= Tutor.find(params[:id])
    return Tutor.hours_this_week_helper(@tutor)
  end
  helper_method :hours_this_week

  def average_hours
    @tutor= Tutor.find(params[:id])
    return Tutor.average_hours_helper(@tutor)
  end
  helper_method :average_hours

  def update
    #This should move to Devise ASAP.
    #NOTE: you can actually change emails, and it will send a confirmation email that, once confirmed, will update your email address.
    #This could be cool, but also you only have one berkeley email, so you shouldn't be allowed to change your email associated with this acc.
    processed_major = tutor_params
    processed_major[:major] = process_major_input params['tutor']['major']
    if @tutor.update(processed_major)
      flash[:success] = "Changes saved"
    else
      flash[:notice] = "Changes not saved"
    end
    redirect_to tutor_path(@tutor)
  end

  def destroy

  end

  def requests

  end

end
