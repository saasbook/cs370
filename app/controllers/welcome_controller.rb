class WelcomeController < ApplicationController
	skip_before_action :verify_authenticity_token
  def index
  end

  def tutor
  end

  def get_login_form
		render FIXTHIS
	end

	respond_to do |format|
	  	flash[:notice] = "Email '#{email}' does not exists."
	  	format.html {redirect_to welcome_tutor_path}
	  	format.json { head :no_content }
	end

  end
end
