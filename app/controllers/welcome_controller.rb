class WelcomeController < ApplicationController
	skip_before_action :verify_authenticity_token
  def index
  end

  def tutor
  end

  def get_login_form
		case params['user_type']
		when 'tutee'
			oiawe;joawefi;j
			format render partial: "/login_form"
		when 'tutor'

		when 'admin'

		end
	end

	respond_to do |format|
	  	flash[:notice] = "Email '#{email}' does not exists."
	  	format.html {redirect_to welcome_tutor_path}
	  	format.json { head :no_content }
	end
end
