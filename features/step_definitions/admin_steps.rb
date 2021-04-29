Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    Admin.create admin
  end
end

Then /I can see current semester "(.*)" title/ do |text|
  expect(page).to have_content(text)
end

When /I make an update for current semester to "(.*)"/ do |text|
  input = text.split(' ')
  semester, year = input[0],  input[1]
  steps %Q{When I choose "#{semester}" from semester list}
  steps %Q{When I input year "#{year}" for current semester}
  click_button("update_current_semester")
end

When /I choose "(.*)" from semester list/ do |semester|
  page.find(:xpath, '//*[@id="update_current_semester_semester"]',visible: false).all(:css, 'option').find { |o| o.text == semester }.select_option
end

When /I input year "(.*)" for current semester/ do |year|
  page.find(:xpath, '//*[@id="update_current_semester_year"]').set(year)
end

Then /I can see courses "(.*)"/ do |course_list|
  course_list.to_s.split(", ").each do |course_name|
    expect(page).to have_content(course_name)
  end
end

Then /I can not see course "(.*)"/ do |course|
  expect(page).to have_no_content(course)
end

Then /I can see tutor "(.*)" with tutor hours (.*)/ do |first,num|
  expect(page).to have_content(first)
  expect(page).to have_content(num)
end


Then /I can see course "(.*)" only once/ do |course|
  expect(page).to have_content(course, maximum: 1)
end

When /I make an update for courses to "(.*)"/ do |course_list|
  obj = page.find(:xpath, '//*[@id="update_courses_courses"]',visible: false)
  # separate course list into a newline separated list rather than comma separated
  obj.set(course_list.to_s.gsub(/, /, "\r\n"))
  # fill_in obj.field, with: course_list.to_s.gsub(/,/, "/r/n")
  click_button("update_courses")
end

When /I update admin password with password "(.*)" and confirmation password "(.*)"/ do |pass, confirmation|
  page.find(:xpath, '//*[@id="update_password_password"]').set(pass)
  page.find(:xpath, '//*[@id="update_password_password_confirmation"]').set(confirmation)
  click_button("update_password")
end

Then /I can see the tutor name "(.*)"/ do |name|
  expect(page).to have_content(name)
end

Then /I can see the composite score of "(.*)"/ do |score|
  expect(page).to have_content(score)
end

Given /"(.*)" has a meeting with tutor "(.*)" meeting id "(.*)" request with tutee id "(.*)" course name "(.*)" and evaluation status "(.*)" knowledge "(.*)" helpful "(.*)" clarity "(.*)" took place "(.*)"/ do |first_name, tutorname, meetid, tuteeid, coursename,stat, kl, hp, cl, tp|

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
  eval.knowledgeable = kl
  eval.helpful = hp
  eval.clarity = cl
  eval.took_place = tp
  eval.save!

  meeting = Meeting.new()
  meeting.request_id = request.id

  meeting.tutor =tutor

  meeting.evaluation_id = eval.id

  meeting.save!
end

Then /I can see sids "(.*)"/ do |sid_list|
  sid_list.to_s.split(", ").each do |sid|
    expect(page).to have_content(sid)
  end
end
Then /I can not see sid "(.*)"/ do |sid|
  expect(page).to have_no_content(sid)
end

When /I make an update for CS61A scholars to "(.*)"/ do |sid_list|
  obj = page.find(:xpath, '//*[@id="update_student_priorities_CS61A"]',visible: false)
  obj.set(sid_list.to_s.gsub(/, /, "\r\n"))
  page.find(:xpath, '//*[@id="update_cs61a_scholars_button"]',visible: false).click
end

When /I make an update for CS61B scholars to "(.*)"/ do |sid_list|
  obj = page.find(:xpath, '//*[@id="update_student_priorities_CS61B"]',visible: false)
  obj.set(sid_list.to_s.gsub(/, /, "\r\n"))
  page.find(:xpath, '//*[@id="update_cs61b_scholars_button"]',visible: false).click
end

When /I make an update for CS61C scholars to "(.*)"/ do |sid_list|
  obj = page.find(:xpath, '//*[@id="update_student_priorities_CS61C"]',visible: false)
  obj.set(sid_list.to_s.gsub(/, /, "\r\n"))
  page.find(:xpath, '//*[@id="update_cs61c_scholars_button"]',visible: false).click
end

When /I make an update for CS70 scholars to "(.*)"/ do |sid_list|
  obj = page.find(:xpath, '//*[@id="update_student_priorities_CS70"]',visible: false)
  obj.set(sid_list.to_s.gsub(/, /, "\r\n"))
  page.find(:xpath, '//*[@id="update_cs70_scholars_button"]',visible: false).click
end

#TODOAUSTIN: Apparently we need to either not use javascript at all in running this test, or switch to chrome instead of firefox to get the necessary functions.
  #https://collectiveidea.com/blog/archives/2012/01/27/testing-file-downloads-with-capybara-and-chromedriver
  #might be better to switch from geckodriver mozilla to chromedriver or whatever, cause it can be run headless if necessary.
  #https://sqa.stackexchange.com/questions/2609/running-webdriver-without-opening-actual-browser-window
When /^I should get a csv download with the filename "([^\"]*)" date$/ do |filename|
  filename = filename+ "#{Date.today}.csv"
  page.driver.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end
