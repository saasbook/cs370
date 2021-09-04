module EvaluationsHelper
  def evaluation_history_helper evaluation
    meeting = Meeting.find_by_id(evaluation.meeting_id)
    request = Request.find_by_id(meeting.request_id)
    tutor = Tutor.find_by_id(meeting.tutor_id)
    @evaluation_details = {name: tutor.first_name+' '+tutor.last_name, course: request.course, subject: request.subject}
  end
end
