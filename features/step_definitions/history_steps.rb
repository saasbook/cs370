When /I click on "(.*)" link/ do |link|
  click_link(link)
end


Then /can see my history request with first_name "(.*)"/ do |name|
  page.should have_content(name)
end

Then /can see my history request with course_name "(.*)"/ do |name|
  page.should have_content(name)
end

Then /can see my history request with status evaluation "(.*)"/ do |status|
  page.should have_content(status)
end
