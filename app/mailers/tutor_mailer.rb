class TutorMailer < ApplicationMailer

	def invite_student(tutor_id, tutee_id, tutor_message, request_id)
		@tutor = Tutor.find_by_id(tutor_id)
		@tutee = Tutee.find_by_id(tutee_id)
		@request = Request.find_by_id(request_id)
		@tutor_message = tutor_message
		mail(to: @tutee.email, subject: 'CS370 Tutoring Invitation')
	end

end
