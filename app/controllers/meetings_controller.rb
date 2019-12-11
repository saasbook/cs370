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
    @eval = Evaluation.where(id: @meeting.evaluation_id).first

    if not @meeting.nil?
      @dates = @meeting.times.map {|time| time.strftime("%A %d at %H:%M")}
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
    @meeting.setTime = params[:meeting][:setTime]
    @meeting.save!
    @tutee = Tutee.find_by_id(params[:tutee_id])

    redirect_to tutee_meeting_path(@tutee, 1)
  end

  def update
  end
  def destroy
  end
end
