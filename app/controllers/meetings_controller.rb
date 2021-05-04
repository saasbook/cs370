class MeetingsController < ApplicationController
  before_action :check_student_logged_in, :except => [:index, :done, :panel_info]
  layout 'tutee_layout'

  def meeting_params
    params.permit(:tutee, :tutor_id, :evaluation_id, :dates, :request_id, :tutee_id)
  end

  def show
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @req = Request.where(tutee_id: params[:tutee_id])
    @meeting = Meeting.where(request_id: @req).last
    if not @meeting.nil?
      @tutor = Tutor.find_by_id(@meeting.tutor_id)
      @eval = Evaluation.find_by_id(@meeting.evaluation_id)

      if @eval&.status == "Complete" or @meeting.is_done?
        @meeting = nil
      end
    end
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

    redirect_to tutee_meetings_path(@tutee)
  end

  def update
    :layout
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @req = Request.where(tutee_id: params[:tutee_id])
    @meeting = Meeting.where(request_id: @req).last
    @tutor = @meeting.tutor_id
  end

  def panel_info
    @meeting = Meeting.find(params['meeting_id'])
    render json:@meeting
  end
end
