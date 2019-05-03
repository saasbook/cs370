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

