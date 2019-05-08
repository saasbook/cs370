class RequestsController < ApplicationController

  before_action :check_tutee_logged_in
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

    if @tutee.privilege == 'No'
      @has_privilege = false
    else
      @has_privilege = true
    end

  end

  def edit
  end

  def create

    # Checks if parameters are good
    if request_params[:subject].blank?
      flash[:message] = "Invalid request: Subject should be filled out."
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
