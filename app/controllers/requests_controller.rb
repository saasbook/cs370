class RequestsController < ApplicationController

  def request_params
    params.require(:request).permit(:tutee_id, :course, :subject, :meeting_length)
  end

  def history
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @requests = Request.where(:tutee_id => params[:tutee_id])
    @evaluations = @tutee.evaluations.where(:status => 'complete')
  end


  def update
    if request_params[:subject].blank?
      flash[:notice] = "Invalid request: Subject should be filled out."
      redirect_to dashboard_path
      return
    else
      @tutee = Tutee.find_by_id(session[:current_user_id])
      @request = Request.find_by_id(params[:id])
      if @request.update(request_params)
        flash[:success] = "Tutoring request for class #{@request.course} was successfully updated!"
      else
        flash[:notice] = "Something went wrong and the requested changes were not made."
      end
    end
    redirect_to dashboard_path
  end

  def create
    # Checks if parameters are good
    if request_params[:subject].blank?
      flash[:notice] = "Invalid request: Subject should be filled out."
      redirect_to dashboard_path
      return
    elsif not Admin.signups_allowed?
      flash[:notice] = "Invalid request: Signups are currently closed."
      redirect_to dashboard_path
      return
    else
      @tutee = Tutee.find_by_id(session[:current_user_id])
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
    redirect_to dashboard_path
  end
end
