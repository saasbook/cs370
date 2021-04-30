class RequestsController < ApplicationController
  before_action :check_tutee_logged_in, :except => [:email, :index]
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
    @tutee_last_req = @tutee.requests.order('created_at ASC').last
    if not @tutee_last_req.nil?
      @meet_for_last_req = @tutee.meetings.where(:request_id => @tutee_last_req.id).first
    end

    if @tutee.privilege == 'No'
      @has_privilege = false
    else
      @has_privilege = true
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
      if @tutee.privilege == 'No'
        @request.meeting_length = '60 minutes'
      else
        @request.meeting_length = request_params[:meeting_length]
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
      if @tutee.privilege == 'No'
        @request.meeting_length = '60 minutes'
      else
        @request.meeting_length = request_params[:meeting_length]
      end
      @request.save!

      flash[:message] = "Tutoring request for class #{@request.course.name} was successfully created!"
    end
    redirect_to tutee_path(@tutee)
  end

  def update
  end
  def destroy
  end

end
