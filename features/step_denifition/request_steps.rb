Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    Request.create request
  end
end

When /I make a request for "(.*)" with topic "(.*)"/ do |course, topic|
  click_link("Request")
  steps %Q{When I choose "#{course}" from course list}
  steps %Q{When I input subject "#{topic}" I want to cover}
end

When /I choose "(.*)" from course list/ do |course|
  page.find(:xpath, '//*[@id="request_course_id"]',visible: false).all(:css, 'option').find { |o| o.text == course }.select_option
end

When /I input subject "(.*)" I want to cover/ do |subject|
  page.find(:xpath, '//*[@id="request_subject"]').set(subject)
end

When /I select Request Tuttor button/ do
  click_button('request_tutor')
end

Then /I can see "(.*)" message pop up/ do |text|
  expect(page).to have_content(text)
end

When /I make a request for "(.*)" without inputting topic/ do |course|
  click_link("Request")
  steps %Q{I choose #{course} from course list}
end

When /I choose "(.*)" from meeting time list/ do |time|
  page.find(:xpath, '//*[@id="request_meeting_length"]',visible: false).all(:css, 'option').find { |o| o.text == time }.select_option
end