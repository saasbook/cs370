
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the login page/
      new_tutee_session_path

    when /the user page for "(.*)"$/
      tutee_path(Tutee.find_by_email($1)[:id])

    when /the update page for "(.*)"$/
      edit_tutee_registration_path(Tutee.find_by_email($1)[:id])

    when /the public edit page with feedback "(.*)"$/
      p Evaluation.all
      @allevals = Evaluation.all
      @eval1 = Evaluation.new()
      @allevals.each do |eval|
        if eval.feedback == ($1)
          hash = eval.hash_id
          @eval1 = eval.clone
          p hash
        end
      end
      edit_evaluation_path(@eval1)

    when /the create account page/
      new_tutee_registration_path

    when /"(.*)'s" tutee page$/
      tutee_path(Tutee.find_by_first_name($1))

    when /the update semester page/
      admin_update_semester_path

    when /the update courses page/
      admin_update_courses_path

    when /the update admin password/
      admin_update_password_path
    when /the update priorities page/
      admin_update_student_priorities_path

    when /the rating tutors page/
      admin_rating_tutors_path

    when /^the home\s?page$/
      '/'

    when /the admin landing page/
      admin_landing_path

    when /the admin home page/
      admin_home_path

    when /tutor signup page/
      new_tutor_path

    when /the welcome page/
      homepage_path

    when /the tutor update page for "(.*)"$/
      edit_tutor_path(Tutor.find_by_email($1)[:id])

    when /the tutor page for "(.*)"$/
      tutor_path(Tutor.find_by_email($1)[:id])

    when /find students page for "(.*)"$/
      tutor_find_students_path(Tutor.find_by_email($1)[:id])

    when /tutor index page/
      tutors_path
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      puts "Can't find mapping"
    end
  end
end

World(NavigationHelpers)
