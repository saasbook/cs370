class TutorMailer < ApplicationMailer

	def invite_student(tutor_id, tutee_id, request_id, eval_id)
		@tutor = Tutor.find_by_id(tutor_id)
		@tutee = Tutee.find_by_id(tutee_id)
		@request = Request.find_by_id(request_id)
		@eval = Evaluation.find_by_id(eval_id)
		mail(to: [@tutee.email], subject: 'CS370 Tutoring: Tutor Matched!')
	end

	def meeting_confirmation(tutor_id, tutee_id, message, request_id, eval_id)
		@tutor = Tutor.find_by_id(tutor_id)
		@tutee = Tutee.find_by_id(tutee_id)
		@request = Request.find_by_id(request_id)
		@message = message
		@eval = Evaluation.find_by_id(eval_id)
		mail(to: [@tutee.email, @tutor.email], subject: 'CS370 Tutoring Session Confirmed!')
	end

	def meeting_complete_notice(tutor_id, tutee_id)
		@tutor = Tutor.find_by_id(tutor_id)
		@tutee = Tutee.find_by_id(tutee_id)
		puts(@tutee.email)
		mail(to: [@tutee.email], subject: 'CS370 Tutoring Session Finished!')
	end
end
