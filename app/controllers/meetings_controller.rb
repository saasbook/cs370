class MeetingsController < ApplicationController
  before_action :check_tutee_logged_in, :except => [:index]
  layout 'tutee_layout'

  def meeting_params
    params.permit(:tutee, :tutor_id, :evaluation_id, :dates, :request_id, :tutee_id)
  end

  def index
  end

  def show
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @req = Request.where(tutee_id: params[:tutee_id])
    @meeting = Meeting.where(request_id: @req).last

    if not @meeting.nil?
      @tutor = Tutor.find_by_id(@meeting.tutor_id)
      @eval = Evaluation.find_by_id(@meeting.evaluation_id)
      if @eval.status == "Complete"
        @meeting = nil
        return
      end
      @dates = @meeting.times.map.with_index {|time, i| [time.strftime("%A %d at %l:%M %p at ") + @meeting.locations[i], i]}.to_h
    end
  end

  def new
   @tutee = Tutee.find_by_id(params[:tutee_id])
   #@dates = [Time.now]
  end

  def edit
  end

  def create
    # Checks if parameters are good
    @req = Request.where(tutee_id: params[:tutee_id])
    @meeting = Meeting.where(request_id: @req).last
    @meeting.set_time = @meeting.times[params[:meeting][:set_time].to_i]
    @meeting.set_location = @meeting.locations[params[:meeting][:set_time].to_i]
    @meeting.is_scheduled = true
    @meeting.save!
    @tutee = Tutee.find_by_id(params[:tutee_id])

    redirect_to tutee_meeting_path(@tutee, 1)
  end

  def update
  end

  def destroy
    @req = Request.where(tutee_id: params[:tutee_id])
    @meeting = Meeting.where(request_id: @req).last
    @eval = Evaluation.find_by_id(@meeting.evaluation_id)
    @meeting.destroy!
    #@eval.destroy!

    flash[:message] = "Your meeting was successfully cancelled. "
    redirect_back(fallback_location:"/")
  end

  def destroy_meeting
    @meeting = Meetings.where(id: params[:id])
    @eval = Evaluation.find_by_id(@meeting.evaluation_id)
    @meeting.destroy!
    @eval.destroy!
    flash[:message] = "Your meeting was successfully cancelled."
    redirect_to tutors_path()
  end
  helper_method :destroy_meeting

end
