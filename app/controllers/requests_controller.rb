class RequestsController < ApplicationController
  before_action :check_valid_tutee, :except => [:email, :index]
  layout 'tutee_layout', :only => [:history, :new]

  def request_params
    params.require(:request).permit(:tutee_id, :course, :subject, :meeting_length)
  end

  def history
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @requests = Request.where(:tutee_id => params[:tutee_id])
    @evaluations = @tutee.evaluations.where(:status => 'Complete')
  end


  def new
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @course_array = Admin.course_list
    @meeting_time = [["1 hour",1], ["1.5 hours",1.5], ["2 hours",2]]
    @has_priority = Admin.priority_list_contains? @tutee
    @tutee_most_recent_request = @tutee.requests.order('created_at ASC').last
    if @tutee_most_recent_request
      status = @tutee_most_recent_request.status
      if status == "closed by admin"
        flash[:notice] = "Your last request was closed by admin. Please fill out a new request!"
      end
      @meet_for_last_req = @tutee.meetings.where(:request_id => @tutee_most_recent_request.id).first
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
      @request.course = request_params[:course]
      @request.subject = request_params[:subject]
      if Admin.priority_list_contains? @tutee.sid
        @request.meeting_length = params[:meeting_length].to_d
      else
        @request.meeting_length = 1
      end
      @request.save!

      flash[:success] = "Tutoring request for class #{@request.course} was successfully changed!"
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
      if Admin.priority_list_contains? @tutee
        @request.meeting_length = request_params[:meeting_length].to_d
      else
        @request.meeting_length = 1
      end
      @request.save!

      flash[:success] = "Tutoring request for class #{@request.course} was successfully created!"
    end
    redirect_to tutee_path(@tutee)
  end
end
