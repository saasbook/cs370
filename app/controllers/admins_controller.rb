class AdminsController < ApplicationController
  layout 'admin_layout', :only => [:home, :update_semester, :updateCurrentSemester, :rating_tutors, :update_courses, :tutor_hours, :update_password, :update_student_priorities]
  before_action :set_admin, except: [:landing, :destroyAdminSession]
  before_action :check_logged_in, except: [:landing, :createAdminSession, :destroyAdminSession]
  
  def landing
  end

  def tutor_hours
    @admin = Admin.find(Admin.master_admin_index)
    @current_semester = Admin.current_semester_formatted
    @tutors = Tutor.all
    @meeting = Meeting.all
    @evaluations = Evaluation.all
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

  def update_semester
    @semester_options = Admin.semester_possibilities
    @current_semester = Admin.current_semester_formatted
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
    redirect_to admin_update_semester_path
  end

  def rating_tutors
    @current_semester = Admin.current_semester_formatted
    @meetings = Meeting.all
    @ratings = calculate_ratings
  end

  def calculate_ratings
    @tutor_ratings = Array.new
    @meetings.each do |meet|
      tutorId = meet.tutor_id
      #a bug fix, sometimes meetings populate more than cucumber test
      if Tutor.find_by_id(tutorId).nil? 
        next
      end
      first = Tutor.find_by_id(tutorId).first_name
      last = Tutor.find_by_id(tutorId).last_name
      knowledgeable, helpful, clarity, composite = _calculate_score_helper(meet)
      found, rate = _check_existing_tutor_helper(@tutor_ratings, tutorId)

      if found
        rate[:knowledgeable] = _calculate_average_helper(rate[:knowledgeable], knowledgeable)
        rate[:helpful] = _calculate_average_helper(rate[:helpful], helpful)
        rate[:clarity] = _calculate_average_helper(rate[:clarity], clarity)
        rate[:composite] = _calculate_average_helper(rate[:composite], composite)
      else
        @tutor_ratings << {tutorId=> "#{first + " " + last}",:knowledgeable => knowledgeable, :helpful => helpful,
                            :clarity => clarity, :composite => composite}
      end
    end
    @tutor_ratings
  end

  def _check_existing_tutor_helper(tutor_rating_list, tutor_id)
    tutor_rating_list.each do |rate|
      if rate.include?(tutor_id)
        return true, rate
      end
    end
    return false, nil
  end

  def _calculate_score_helper(meet)
    knowledgeable_sc = Evaluation.find_by_id(meet.evaluation_id).knowledgeable
    helpful_sc = Evaluation.find_by_id(meet.evaluation_id).helpful
    clarity_sc = Evaluation.find_by_id(meet.evaluation_id).clarity
    composite_sc = (knowledgeable_sc + helpful_sc + clarity_sc) / 3.0
    return knowledgeable_sc, helpful_sc, clarity_sc, composite_sc
  end

  def _calculate_average_helper(a, b)
    return (a + b) / 2.0
  end

  def updateSemesterHelper val
    return params[val][:semester], params[val][:year]
  end

  def update_courses
    @current_courses = Course.current_courses_formatted
  end

  def post_update_courses
    if not params[:update_courses].nil? and not params[:update_courses][:courses].nil? and Course.update_courses(params[:update_courses][:courses])
      flash[:message] = "Courses updated. Any new courses should be visible below, if not try again."
    else
      flash[:notice] = "Courses update failed. Make sure courses are properly separated (one per line)."
    end
    redirect_to admin_update_courses_path
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
