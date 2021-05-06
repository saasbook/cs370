Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    Request.create! request
  end
end

When /I make a request for "(.*)" with topic "(.*)"/ do |course, topic|
  click_link("Request")
  steps %Q{When I choose "#{course}" from course list}
  steps %Q{When I input subject "#{topic}" I want to cover}
end

When /I choose "(.*)" from course list/ do |course|
  steps %Q{When I select "#{course}" from "request_course_id"}
end

When /I input subject "(.*)" I want to cover/ do |subject|
  page.find(:xpath, '//*[@id="request_subject"]').set(subject)
end

When /I select Request tutor button/ do
  click_button('request_tutor')
end

When /I make a request for "(.*)" without inputting topic/ do |course|
  click_link("Request")
  steps %Q{I choose #{course} from course list}
end

When /I choose "(.*)" from meeting time list/ do |time|
  page.find(:xpath, '//*[@id="request_meeting_length"]',visible: false).all(:css, 'option').find { |o| o.text == time }.select_option
end
