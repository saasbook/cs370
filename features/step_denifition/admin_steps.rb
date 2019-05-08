Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    Admin.create admin
  end
end

Then /I can see current semester "(.*)" title at admin home page/ do |text|
  expect(page).to have_content(text)
end

Then /I can see semester statistic "(.*)" title at admin home page/ do |text|
  expect(page).to have_content(text)
end

When /I make an update for current semester to "(.*)"/ do |text|
  input = text.split(' ')
  semester, year = input[0],  input[1]
  steps %Q{When I choose "#{semester}" from semester list}
  steps %Q{When I input year "#{year}" for current semester}
  
  # steps %Q{When I press 'update_current_semester' button}
  click_button("update_current_semester")
end

When /I choose "(.*)" from semester list/ do |semester|
  page.find(:xpath, '//*[@id="update_current_semester_semester"]',visible: false).all(:css, 'option').find { |o| o.text == semester }.select_option
end

When /I input year "(.*)" for current semester/ do |year|
  page.find(:xpath, '//*[@id="update_current_semester_year"]').set(year)
end

When /I make an update for semester statistic to "(.*)"/ do |text|
  input = text.split(' ')
  semester, year = input[0],  input[1]
  steps %Q{When I choose "#{semester}" from semester statistic list}
  steps %Q{When I input year "#{year}" for semester statistic}
  # steps %Q{When I press "update_statistics_semester" button}
  click_button("update_statistics_semester")
end

When /I choose "(.*)" from semester statistic list/ do |semester|
  page.find(:xpath, '//*[@id="update_statistics_semester_semester"]',visible: false).all(:css, 'option').find { |o| o.text == semester }.select_option
end

When /I input year "(.*)" for semester statistic/ do |year|
  page.find(:xpath, '//*[@id="update_statistics_semester_year"]').set(year)
end

Then /I can see courses "(.*)"/ do |course_list|
  course_list.to_s.split(", ").each do |course_name|
    expect(page).to have_content(course_name)
  end
end

Then /I can not see course "(.*)"/ do |course|
  expect(page).to have_no_content(course)
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
