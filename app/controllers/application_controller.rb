class ApplicationController < ActionController::Base
  protect_from_forgery
  private
    def check_tutee_logged_in
      puts "Current session value: "
      puts session[:tutee_id].nil?
      puts session[:tutee_id].to_i
      puts params[:id].to_i
      puts params[:tutee_id].to_i
      tutee_id = params.has_key?(:tutee_id) ? params[:tutee_id] : -1
      if tutee_id == -1 and params.has_key?(:id)
        tutee_id = params[:id]
      end 

      if !(session[:tutee_id].to_i == tutee_id.to_i)
        redirect_to tutees_path
      end
    end
end
