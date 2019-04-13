Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    Request.create request
  end
end

When /I make a request for "(.*)" with topic "(.*)"/ do |course, topic|
  steps %(I choose #{course} from course list
          I input subject #{topic} I want to cover
          I press "Request Tutor" button)
end

When /I choose "(.*)" from course list/ do |course|
  select course, :from => 'dropdown'
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
  steps %(I choose #{course} from course list
          I press "Request Tutor" button)
end