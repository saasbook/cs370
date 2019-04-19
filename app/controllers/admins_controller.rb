class AdminsController < ApplicationController
  before_action :set_admin, only: [:createAdminSession, :home]
  before_action :check_logged_in, except: [:landing, :createAdminSession, :destroyAdminSession]
  # GET /admins
  # GET /admins.json
  def landing
    
  end
 
  def createAdminSession
    @admin =Admin.find(Admin.master_admin_index)
    if @admin and @admin.authenticate(params[:password])
      session[:admin_logged_in] = true
      redirect_to admin_home_path
    else
      redirect_to admin_landing_path
    end
  end

  def destroyAdminSession
    session[:admin_logged_in] = false
    redirect_to admin_landing_path
  end

  private
    def check_logged_in
      if session[:admin_logged_in].nil? or not session[:admin_logged_in]
        redirect_to admin_landing_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(Admin.master_admin_index)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:password, :password_confirmation, :statistics_semester, :current_semester)
    end
end
