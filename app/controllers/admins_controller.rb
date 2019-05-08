class AdminsController < ApplicationController
  before_action :set_admin, except: [:landing, :destroyAdminSession]
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

  def home
    @semester_options = Admin.semester_possibilities
    @current_semester = Admin.current_semester_formatted
    @statistics_semester = Admin.statistics_semester_formatted
    @current_courses = Course.current_courses_formatted
  end

  def updateCurrentSemester
    if not params[:update_current_semester].nil? 
      c_sem = params[:update_current_semester][:semester]
      c_year = params[:update_current_semester][:year]
    end
    if not c_sem.nil? and not c_year.nil? and Admin.validate_year(c_year)
      # also update the courses along with updating the semester
      @old_semester_courses = Course.current_courses_formatted
      @admin.update(:current_semester => c_sem + c_year)
      Course.update_courses(@old_semester_courses) # relies on the current semester so should auto populate the new semester with the old courses
    else
      flash[:curr_message] = "Error updating current semester, year is likely mistyped"
    end
    redirect_to admin_home_path
  end
  def updateStatisticsSemester
    if not params[:update_statistics_semester].nil? 
      c_sem = params[:update_statistics_semester][:semester]
      c_year = params[:update_statistics_semester][:year]
    end
    if not c_sem.nil? and not c_year.nil? and Admin.validate_year(c_year)
      @admin.update(:statistics_semester => c_sem + c_year)
    else
      flash[:stat_message] = "Error updating statistics semester, year is likely mistyped"
    end
    redirect_to admin_home_path
  end

  def updateCourses
    if not params[:update_courses].nil? and not params[:update_courses][:courses].nil? and Course.update_courses(params[:update_courses][:courses])
      flash[:course_message] = "Courses updated. Any new courses should be visible below, if not try again."
    else
      flash[:course_message] = "Courses update failed. Make sure courses are properly separated (one per line)."
    end
    redirect_to admin_home_path
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
