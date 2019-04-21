class WelcomeController < ApplicationController
	skip_before_action :verify_authenticity_token
  def index
  end

  def tutor
  end

  def login
    email = params[:email]
    password = params[:password]
	if Tutor.where(email: email).exists?
		params[:id] = Tutor.where(email: email).first.id
		redirect_to tutor_path(params[:id])
		return
	end 

	respond_to do |format|
	  	flash[:notice] = "Email '#{email}'' does not exists."
	  	format.html {redirect_to welcome_tutor_path}
	  	format.json { head :no_content }
	end
  	
  end
end