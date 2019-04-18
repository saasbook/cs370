Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    Request.create request
  end
end

When /I make a request for "(.*)" with topic "(.*)"/ do |course, topic|
  click_link("Request")
  steps %Q{When I choose "#{course}" from course list}
  steps %Q{When I input subject "#{topic}" I want to cover}
  steps %Q{When I press "request_tutor" button}
end

When /I choose "(.*)" from course list/ do |course|
  page.find(:xpath, '//*[@id="request_course_id"]',visible: false).all(:css, 'option').find { |o| o.text == course }.select_option
  #select course, :from => 'course_list', visible: false
end

When /I input subject "(.*)" I want to cover/ do |subject|
  page.find(:xpath, '//*[@id="request_subject"]').set(subject)
end

When /I press "(.*)" button/ do |button|
  click_button(button)
end

Then /I can see "(.*)" message pop up/ do |text|
  expect(page).to have_content(text)
end

When /I make a request for "(.*)" without inputting topic/ do |course|
  click_link("Request")
  steps %Q{I choose #{course} from course list}
  steps %Q{When I press "request_tutor" button}
end