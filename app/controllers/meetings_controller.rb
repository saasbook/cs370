class MeetingsController < ApplicationController
  layout 'tutee_layout'

  def meeting_params
    params.permit(:tutee, :tutor_id, :evaluation_id, :dates, :request_id, :tutee_id)
  end

  def show
    :check_valid_tutee
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

  def panel_info
    :check_valid_tutor
    @meeting = Meeting.find(params['meeting_id'])
    render json:@meeting
  end
end
