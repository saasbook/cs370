Given /the following meetings exist/ do |meetings_table|
  meetings_table.hashes.each do |meet|
    Meeting.create meet
  end
end

Given /the following evaluations exist/ do |evaluations_table|
  evaluations_table.hashes.each do |eval|
    Evaluation.create eval
  end
end

Then /can see my evaluation form with course name (.*)/ do |name|
  page.should have_content(name)
end

Then /can see my evaluation form with tutor name (.*)/ do |name|
  page.should have_content(name)
end

Then /can see my evaluation form with status(.*)/ do |name|
  page.should have_content(name)
end


Given /"(.*)" had a meeting with tutor "(.*)" with meeting id "(.*)" request having tutuee id "(.*)" course name "(.*)" and evaluation status "(.*)" feedback "(.*)" and set time "(.*)"/ do |first_name, tutorname, meetid, tuteeid, coursename,stat,feed, settime|
  tutee = Tutee.find_by_first_name(first_name)
  tutor = Tutor.find_by_first_name(tutorname)
  request = Request.new()
  request.tutee_id = tutee.id
  course = Course.find_by_name(coursename)
  course.name = coursename
  request.course_id = course.id
  request.save!
  eval = Evaluation.new()
  eval.status = stat
  eval.feedback = feed
  eval.save!
  meeting = Meeting.new()
  meeting.request_id = request.id
  meeting.tutor_id = tutor.id
  meeting.evaluation_id = eval.id
  if not settime == "nil"
    meeting.set_time = Time.parse(settime)
  end
  meeting.save!

end


Given /"(.*)" had a meeting with tutor "(.*)" with meeting id "(.*)" request having tutuee id "(.*)" course name "(.*)" and evaluation status "(.*)" times "(.*)" and locations "(.*)"/ do |first_name, tutorname, meetid, tuteeid, coursename,stat, times, locations|
  tutee = Tutee.find_by_first_name(first_name)
  tutor = Tutor.find_by_first_name(tutorname)
  request = Request.new()
  puts "Tutee id"
  puts tutee.first_name
  request.tutee_id = tutee.id
  course = Course.find_by_name(coursename)
  course.name = coursename
  puts "course id"
  request.course_id = course.id
  puts course.id
  request.save!
  eval = Evaluation.new()
  eval.status = stat
  eval.save!
  meeting = Meeting.new()
  meeting.request_id = request.id
  meeting.times = times.split(",")
  meeting.locations = locations.split(",")

  puts request.id 
  meeting.tutor_id = tutor.id
  puts tutor.id
  meeting.evaluation_id = eval.id
  puts eval.id
  meeting.save!

end

####################### NOT WORKING PROPERLY
# Given /"(.*)" requests tutoring for course name "(.*)"/ do |first_name, coursename,|
#   tutee = Tutee.find_by_first_name(first_name)
#   request = Request.new()
#   request.tutee_id = tutee.id
#   course = Course.find_by_name(coursename)
#   course.name = coursename
#   request.course_id = course.id
#   request.save!
# end
#
# Given /"(.*)" gets matched with tutor "(.*)" for course name "(.*)"/ do |first_name, tutorname, coursename,|
#   tutee = Tutee.find_by_first_name(first_name)
#   tutor = Tutor.find_by_first_name(tutorname)
#   request = Request.new()
#   request.tutee_id = tutee.id
#   course = Course.find_by_name(coursename)
#   course.name = coursename
#   request.course_id = course.id
#   request.save!
#   eval = Evaluation.new()
#   eval.status = "Pending"
#   eval.save!
# end
#
# Then /I should have a new evaluation form created/ do
#   eval = Evaluation.new()
#   eval.status = "Pending"
#   eval.save!
# end

And /I fill out the evaluation that didn't happen and submit/ do
  step %{I choose "radioButton"}
  step %{I press "Submit Evaluation"}
end

And /I fill out the evaluation and submit/ do
  step %{I choose "radioButton2"}
  step %{I fill in "disabled1" with "Tree Recursion, blahh blahh"}
  step %{I choose "disabled8"}
  step %{I fill in "disabled9" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I fill in "disabled10" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I fill in "disabled11" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I choose "disabled13"}
  step %{I choose "disabled18"}
  step %{I choose "disabled23"}
  step %{I choose "disabled28"}
  step %{I fill in "disabled32" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I press "Submit Evaluation"}
end

And /I partially fill out the evaluation and submit/ do
  step %{I choose "radioButton2"}
  step %{I fill in "disabled1" with "Tree Recursion, blahh blahh"}
  step %{I choose "disabled8"}
  step %{I fill in "disabled9" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I fill in "disabled10" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I fill in "disabled11" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I fill in "disabled32" with "The bamba was a good movie, so tragic though. I like peanut butter scotch. I made ham."}
  step %{I press "Submit Evaluation"}
end

Given /I was given the page with evaluation hash id "(.*)"/ do |hash|
  # p Evaluation.all
  @tutors = Tutor.all
  p @tutors
  @tutees = Tutee.all
  p @tutees
  @evaluation = Evaluation.all
  p @evaluation

   # step %{I partially fill out the evaluation and submit}
  # p eval
  # visit edit_evaluation_path(@eval.hash_id)
#
end

# Given /I login as "(.*)"/ do |name|
#   step %{I am on the login page}
#   step %{I fill in "username" with "#{Tutee.find_by_first_name(name).email}"}
#   step %{I fill in "password" with "topsecret"}
#   step %{press "Log in"}
# end
