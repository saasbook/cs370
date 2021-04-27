class WelcomeController < ApplicationController
	skip_before_action :verify_authenticity_token

  def get_login_form
		case params['user_type']
		when 'tutee'
			return render json: {partial: render_to_string(partial: 'welcome/tutor_tutee_login_form', locals:{user_type: params['user_type'], user_type_object: Tutee.new})}
		when 'tutor'
			return render json: {partial: render_to_string(partial: 'welcome/tutor_tutee_login_form', locals:{user_type: params['user_type'], user_type_object: Tutor.new})}
		when 'admin'
			return render json: {partial: render_to_string(partial: 'welcome/admin_login_form')}
		end
	end
end
