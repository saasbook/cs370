class AdminsController < ApplicationController
  layout 'admin_layout', :only => [:home, :manage_semester, :updateCurrentSemester, :rating_tutors, :update_courses, :tutor_hours, :update_password, :update_student_priorities, :manage_tutors]
  before_action :set_admin, except: [:landing, :destroyAdminSession]
  before_action :check_logged_in, except: [:landing, :createAdminSession, :destroyAdminSession]
  
  def landing
  end

  def export_table
    table = params[:export_table][:table]
    case table
    when "Tutors"
      respond_to do |format|
        format.html
        format.csv {send_data Tutor.to_csv, filename: "tutors-#{Date.today}.csv"}
      end
    when "Tutees"
      respond_to do |format|
        format.html
        format.csv {send_data Tutee.to_csv, filename: "tutees-#{Date.today}.csv"}
      end
    when "Requests"
      respond_to do |format|
        format.html
        format.csv {send_data Request.to_csv, filename: "requests-#{Date.today}.csv"}
      end
    when "Meetings"
      respond_to do |format|
        format.html
        format.csv {send_data Meeting.to_csv, filename: "meetings-#{Date.today}.csv"}
      end
    when "Evaluations"
      respond_to do |format|
        format.html
        format.csv {send_data Evaluation.to_csv, filename: "evaluations-#{Date.today}.csv"}
      end
    when "Courses"
      respond_to do |format|
        format.html
        format.csv {send_data Course.to_csv, filename: "courses-#{Date.today}.csv"}
      end
    end
  end

  def tutor_hours
    @admin = Admin.find(Admin.master_admin_index)
    @current_semester = Admin.current_semester_formatted
    @tutors = Tutor.all
    @meeting = Meeting.all
    @evaluations = Evaluation.all
    @courses = Course.where(:active => true)
    @demographics = ['Asian','Black/African','Caucasian', 'Hispanic/Latinx', 'Native American', 
      'Pacific Islander', 'Mixed', 'Other', 'Male','Female','Non-Binary']
  end

  def tutor_hours_export
    @tutors = Tutor.all

    respond_to do |format|
      format.html
      format.csv {send_data @tutors.hours_to_csv, filename: "tutor-hours-#{Date.today}.csv"}
    end
  end

  def demographic_hours_export
    @evaluations = Evaluation.all

    respond_to do |format|
      format.html
      format.csv {send_data @evaluations.hours_demographic_to_csv, filename: "demographic-hours-#{Date.today}.csv"}
    end
  end

  def course_hours_export
    @evaluations = Evaluation.all

    respond_to do |format|
      format.html
      format.csv {send_data @evaluations.hours_course_to_csv, filename: "course-hours-#{Date.today}.csv"}
    end
  end

  def manage_tutors
    @tutors = Tutor.all
  end

  def delete_tutor
    email = params[:delete_tutor][:email]
    tutor_to_delete = Tutor.where(:email => email).first
    if tutor_to_delete.nil?
      flash[:notice] = "No tutor with email #{email} exists."
    else
      flash[:message] = "Tutor #{email} successfully deleted."
      meetings_to_delete = Meeting.where(:tutor => tutor_to_delete).delete_all
      tutor_to_delete.destroy
    end
    redirect_to admin_manage_tutors_path
  end

  def createAdminSession
    @admin = Admin.find(Admin.master_admin_index)
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
  end

  def manage_semester
    @semester_options = Admin.semester_possibilities
    @current_semester = Admin.current_semester_formatted
    @signups_allowed = Admin.signups_allowed
    @tables = ["Tutors", "Tutees", "Requests", "Meetings", "Evaluations", "Courses"]
  end

  def toggle_signups
    signups_allowed = !Admin.signups_allowed
    Admin.toggle_signups
    if signups_allowed
      flash[:message] = "Signups have been turned on."
    else
      flash[:message] = "Signups have been turned off."
    end
    redirect_to admin_manage_semester_path
  end

  def updateCurrentSemester
    if not params[:update_current_semester].nil?
      c_sem, c_year = updateSemesterHelper(:update_current_semester)
    end
    if not c_sem.nil? and not c_year.nil? and Admin.validate_year(c_year)
      # also update the courses along with updating the semester
      flash[:message] = "Current semester was successfully updated."
      @old_semester_courses = Course.current_courses_formatted
      @admin.update(:current_semester => c_sem + c_year)
      Course.update_courses(@old_semester_courses) # relies on the current semester so should auto populate the new semester with the old courses
    else
      flash[:notice] = "Error updating current semester, year is likely mistyped"
    end
    redirect_to admin_manage_semester_path
  end

  def rating_tutors
    @tutors = Tutor.all
  end

  def rating_tutors_export
    @tutors = Tutor.all

    respond_to do |format|
      format.html
      format.csv {send_data @tutors.ratings_to_csv, filename: "tutor-ratings-#{Date.today}.csv"}
    end
  end

  def updateSemesterHelper val
    return params[val][:semester], params[val][:year]
  end

  def update_password

  end

  def post_update_password
    password, confirmation_password = params[:update_password][:password], params[:update_password][:password_confirmation]
    if password == confirmation_password
      if @admin.update(:password => password)
        flash[:message] = "Admin password successfully updated."
      end
    else
      flash[:notice] = "Passwords do not match"
    end
    redirect_to admin_update_password_path
  end

  def update_student_priorities
    @current_cs61a_scholars = Tutee.get_current_cs61a_sids_formatted
    @current_cs61b_scholars = Tutee.get_current_cs61b_sids_formatted
    @current_cs61c_scholars = Tutee.get_current_cs61c_sids_formatted
    @current_cs70_scholars = Tutee.get_current_cs70_sids_formatted
  end

  def update_student_priorities_61A
    if not params[:update_student_priorities].nil? and not params[:update_student_priorities][:CS61A].nil? and Tutee.update_cs61a_privileges(params[:update_student_priorities][:CS61A])
      flash[:message] = "CS61A privileges have been updated. Any new courses should be visible below, if not try again."
    else
      flash[:notice] = "CS61A privileges update failed. Make sure courses are properly separated (one per line)."
    end
    redirect_to admin_update_student_priorities_path
  end

  def update_student_priorities_61B
    if not params[:update_student_priorities].nil? and not params[:update_student_priorities][:CS61B].nil? and Tutee.update_cs61b_privileges(params[:update_student_priorities][:CS61B])
      flash[:message] = "CS61B privileges have been updated. Any new courses should be visible below, if not try again."
    else
      flash[:notice] = "CS61B privileges update failed. Make sure courses are properly separated (one per line)."
    end
    puts (not params[:update_student_priorities].nil?)
    puts (not params[:update_student_priorities][:CS61B].nil?)
    redirect_to admin_update_student_priorities_path
  end

  def update_student_priorities_61C
    if not params[:update_student_priorities].nil? and not params[:update_student_priorities][:CS61C].nil? and Tutee.update_cs61c_privileges(params[:update_student_priorities][:CS61C])
      flash[:message] = "CS61C privileges have been updated. Any new courses should be visible below, if not try again."
    else
      flash[:notice] = "CS61C privileges update failed. Make sure courses are properly separated (one per line)."
    end
    redirect_to admin_update_student_priorities_path
  end

  def update_student_priorities_70
    if not params[:update_student_priorities].nil? and not params[:update_student_priorities][:CS70].nil? and Tutee.update_cs70_privileges(params[:update_student_priorities][:CS70])
      flash[:message] = "CS70 privileges have been updated. Any new courses should be visible below, if not try again."
    else
      flash[:notice] = "CS70 privileges update failed. Make sure courses are properly separated (one per line)."
    end
    redirect_to admin_update_student_priorities_path
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
