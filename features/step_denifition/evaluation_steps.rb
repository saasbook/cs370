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


Given /"(.*)" had a meeting with tutor "(.*)" with meeting id "(.*)" request having tutuee id "(.*)" course name "(.*)" and evaluation status "(.*)"/ do |first_name, tutorname, meetid, tuteeid, coursename,stat|
  tutee = Tutee.find_by_first_name(first_name)
  tutor = Tutor.find_by_first_name(tutorname)
  request = Request.new()
  puts "Tutee id"
  puts tutee.id
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
  puts request.id
  meeting.tutor_id = tutor.id
  puts tutor.id
  meeting.evaluation_id = eval.id
  puts eval.id
  meeting.save!

end
