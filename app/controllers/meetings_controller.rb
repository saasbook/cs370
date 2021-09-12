class MeetingsController < ApplicationController

  def meeting_params
    params.permit(:tutee, :tutor_id, :evaluation_id, :dates, :request_id, :tutee_id)
  end

  def show
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @req = Request.where(tutee_id: params[:tutee_id])
    @meeting = Meeting.where(request_id: @req).last
    if not @meeting.nil?
      @tutor = Tutor.find_by_id(@meeting.tutor_id)
      @eval = @meeting.evaluation

      if @eval.complete? or @meeting.finished?
        @meeting = nil
      end
    end
  end

  def panel_info
    @meeting = Meeting.find(params['meeting_id'])
    render json:@meeting
  end
end
