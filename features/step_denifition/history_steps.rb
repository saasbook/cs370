Given /"(.*)" has a request with course name "(.*)" with subject "(.*)"/ do |first_name, name, subject|
  tutee = Tutee.find_by_first_name(first_name)
  request = Request.new()
  request.tutee_id = tutee.id
  course = Course.find_by_name(name)
  course.name = name
  request.course_id = course.id
  request.subject = subject
  request.save!
end

Given /"(.*)" has no request/ do |first_name|
  tutee = Tutee.find_by_first_name(first_name)
  request = nil
end

When /I click on "(.*)" link/ do |link|
  click_link(link)
end


Then /I should not see request of "(.*)"/ do |name|
  page.should_not have_field('Tutee Name', with: name)
end

Then /can see my history request with first_name "(.*)"/ do |name|
  page.should have_content(name)
end

Then /can see my history request with semester "(.*)"/ do |course|
  page.should have_content(course)
end

Then /can see my history request with course_num "(.*)"/ do |course|
  page.should have_content(course)
end

Then /can see my history request with course_name "(.*)"/ do |name|
  page.should have_content(name)
end

Then /can see my history request with subject "(.*)"/ do |sub|
  page.should have_content(sub)
end