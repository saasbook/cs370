Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    Request.create request
  end
end

When /I make a request for "(.*)" with topic "(.*)"/ do |course, topic|
  steps %Q{When I choose "#{course}" from course list}
  steps %Q{When I input subject #{topic} I want to cover}
  steps %Q{When I press "request_tutor" button}
end

When /I choose "(.*)" from course list/ do |course|
  select course, :from => 'course_list'
end

When /I input subject "(.*)" I want to cover/ do |subject|
  fill_in('subject', :with => subject)
end

When /I press "(.*)" button/ do |button|
  click_button(button)
end

Then /I can see "(.*)" message pop up/ do |text|
  expect(page).to have_content(text)
end

When /I make a request for "(.*)" without inputting topic/ do |course|
  steps %Q{I choose #{course} from course list}
  steps %Q{I press "Request Tutor" button}
end