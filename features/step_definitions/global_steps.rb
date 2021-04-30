require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

And /byebug/ do
  byebug
end

And /debug/ do
  #use this to insert a debug anytime you're troubleshooting features
  puts edit_tutee_path(Tutee.find_by_last_name("One"))
end

#POPUP INTERACTIONS
When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end
When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end
When /^(?:|I )see the element with id (.+) raise a validation error (.+)$/ do |el_id, err|
  page.find_by_id(el_id.gsub(/\"/, '')).native.attribute(err)
end

#PAGE NAVIGATIONS
When /^(?:|I )refresh/ do
  visit current_path
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end
Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end
And /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

When /^(?:|I )press link "([^"]*)"$/ do |link|
  click_link(link)
end
When /I click on "(.*)" link/ do |link|
  click_link(link)
end
When /^(?:|I )follow "([^"]*)"$/ do |link|
  # click_link(link)
  first(:link, link, exact: true).click #handles ambiguous case
end


Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content("#{arg1}")
end
Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

And /^ajax has loaded$/ do
  wait_for_ajax
end

#FORM INTERACTIONS
When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end
When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end
When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

And /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  if value == "general_seed_password"
    fill_in(field, :with => Admin.general_seed_password)
  else
    fill_in(field, :with => value)
  end
end
And /^(?:|I )change "([^"]*)" to "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end
And /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end
When /^"([^"]*)" is selected for "([^"]*)"$/ do |selected_text, dropdown|
  select selected_text, :from => dropdown
  #msg = "Selected: #{sb_selected.text.inspect} - value:#{sb_selected.value.inspect}"
  #assert page.has_select?(dropdown, selected: selected_text)
end
And /^(?:|I )bootstrap select "([^"]*)" from "([^"]*)"$/ do |value, field|
  bootstrap_select value, from: field
end
