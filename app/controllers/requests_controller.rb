class RequestsController < ApplicationController
  before_action :check_student_logged_in, :except => [:email, :index]
  layout 'tutee_layout', :only => [:history, :new]

  def request_params
    params.require(:request).permit(:tutee_id, :course_id, :subject, :meeting_length)
  end

  def index
  end

  def show
  end

  def history
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @requests = Request.where(:tutee_id => params[:tutee_id])
    @evaluations = @tutee.evaluations.where(:status => 'Complete')
  end

  def new
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @course_array = Course.course_array
    @meeting_time = %w(60\ minutes 90\ minutes 120\ minutes)
    @has_priority = Admin.priority_list_contains? @tutee.sid
    @tutee_last_req = @tutee.requests.order('created_at ASC').last
    if not @tutee_last_req.nil?
      @tutee_last_req_closed = @tutee_last_req.closed
      if @tutee_last_req_closed
        flash[:notice] = "Your last request was closed by admin. Please fill out a new request!"
      end
      @meet_for_last_req = @tutee.meetings.where(:request_id => @tutee_last_req.id).first
    end

    @signups_allowed = Admin.signups_allowed

  end

  def edit
    # Checks if parameters are good
    @request = Request.find_by_id(params[:id])
    @tutee = Tutee.find_by_id(params[:tutee_id])
    if request_params[:subject].blank?
      flash[:notice] = "Invalid request: Subject should be filled out."
      redirect_to new_tutee_request_path(:tutee_id => params[:tutee_id])
      return
    else
      @request.course_id = request_params[:course_id]
      @request.subject = request_params[:subject]
      if Admin.priority_list_contains? @tutee.sid
        @request.meeting_length = params[:meeting_length]
      else
        @request.meeting_length = '60 minutes'
      end
      @request.save!

      flash[:message] = "Tutoring request for class #{@request.course.name} was successfully changed!"
    end
    redirect_to tutee_path(@tutee)
  end

  def create

    # Checks if parameters are good
    if request_params[:subject].blank?
      flash[:notice] = "Invalid request: Subject should be filled out."
      redirect_to new_tutee_request_path
      return
    elsif not Admin.signups_allowed
      flash[:notice] = "Invalid request: Signups are currently closed."
      redirect_to new_tutee_request_path
      return
    else
      @tutee = Tutee.find_by_id(params[:tutee_id])
      @request = Request.new(request_params)
      @request.tutee_id = @tutee.id
      @request.course_id = request_params[:course_id]
      if Admin.priority_list_contains? @tutee.sid
        @request.meeting_length = request_params[:meeting_length]
      else
        @request.meeting_length = '60 minutes'
      end
      @request.save!

      flash[:message] = "Tutoring request for class #{@request.course.name} was successfully created!"
    end
    redirect_to tutee_path(@tutee)
  end

  def update
  end
  def destroy
    #@request = Request.find_by_id(params[:id])
    #@request.destroy!
    #redirect_to tutee_path(@tutee)
  end
  def email
    tid = params[:tutor_id]
    sid = params[:student][:id]
    requestid = params[:student][:requestid]
    #tutee_id = params[:tutee_id]
    tutor_message = "Hi, you have a matched tutor, please check the website for more details."
    @eval = Evaluation.create!()
    QuestionTemplate.ordered_list_of_question_templates.each do |qt|
      Question.create(evaluation_id: @eval.id, question_template_id: qt.id, prompt: qt.prompt)
    end

    @times = []
    i = 1
    while not params["Date" + i.to_s].nil?
        @d1 = params["Date" + i.to_s]
        @temp = @d1[0..1]
        @d1[0,1] = @d1[3,4]
        @d1[3,5] = @temp
        @times << Time.parse(@d1 + " " + params["Time" + i.to_s])
        @d1 = ""
        @temp = ""
        i += 1
    end

    @locs = []
    i = 1
    while not params["Location" + i.to_s].nil?
        @locs << params["Location" + i.to_s]
        i += 1
    end

    @meeting = Meeting.create({:tutor_id => tid.to_i, :request_id => requestid.to_i, :evaluation_id => @eval.id, :tutee_id => sid, :times => @times, :locations => @locs});
    begin
      TutorMailer.invite_student(tid, sid, tutor_message, requestid, @eval.id).deliver_now
    rescue StandardError
      flash[:message] = "An error occured when sending out confirmation emails."
    end
    flash[:notice] = "Successfully matched!"
    redirect_to tutor_path(tid)
  end
end
