class ApplicationController < ActionController::Base
  protect_from_forgery
  private
    def check_tutee_logged_in
      puts "Current session value: "
      puts session[:tutee_id].nil?
      puts session[:tutee_id]
      if !(session[:tutee_id].to_i == params[:id].to_i or session[:tutee_id].to_i == params[:tutee_id].to_i)
        redirect_to tutees_path
      end
    end
end
