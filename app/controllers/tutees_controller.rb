class TuteesController < ApplicationController
  layout 'tutee_layout', :only => [:show, :edit]
  # Authorization section

  def index
    redirect_to homepage_path
  end


  def show
    if params[:id] == "password"
      redirect_to new_tutee_password_path
    else
      @courses = Admin.course_list
      @tutee = Tutee.find_by_id(params[:id])
      @requests = show_helper_requests @tutee
      @evaluations = @tutee.evaluations
      @meeting = Meeting.where(request_id: @requests).last
      @meeting = show_helper_meeting_processing @meeting
    end
  end

  def show_helper_requests tutee
    tutee.requests.where('created_at >= ?', Date.today.beginning_of_week.strftime("%Y-%m-%d"))
  end

  def show_helper_meeting_processing meeting
    if not meeting.nil?
      @lastEval = meeting.evaluation
      if @lastEval&.status == "Complete"
        return nil
      else
        return meeting
      end
    end
  end
end
