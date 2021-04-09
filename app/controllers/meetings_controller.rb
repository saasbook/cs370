class MeetingsController < ApplicationController
  # before_action :check_tutee_logged_in, :except => [:index]
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

      if @eval.status == "Complete" or @meeting.is_done?
        @meeting = nil
        return
      end

      @dates = @meeting.times.map.with_index {|time, i| [time.strftime("%A %d at %l:%M %p at ") + @meeting.locations[i], i]}.to_h
      tid = params[:tutor_id]
      sid = params[:tutee_id]
      requestid = params[:requestid]
      message = "Hi, your tutoring session has been confirmed at " + String(@meeting.set_time) + ", Taking place at " + String(@meeting.set_location) + "."
      begin
        TutorMailer.meeting_confirmation(tid, sid, message, requestid, @eval.id).deliver_now
      rescue StandardError
        flash[:message] = "An error occured when sending out confirmation emails."
      end
    end
  end

  def new
   @tutee = Tutee.find_by_id(params[:tutee_id])
   #@dates = [Time.now]
  end

  def done
   @meeting = Meeting.find_by_id(params[:meeting_id])
   @meeting.is_done = true
   @meeting.save!

   redirect_back(fallback_location:"/")
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
    @eval.destroy!

    flash[:message] = "Your meeting was successfully cancelled."
    redirect_back(fallback_location:"/")
  end

end
