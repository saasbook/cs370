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

end
