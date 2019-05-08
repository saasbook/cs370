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

Given /the following tutees exist/ do |tutees_table|
  tutees_table.hashes.each do |tutee|
    Tutee.create tutee
  end
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

And /^(?:|I )change "([^"]*)" to "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content("#{arg1}")
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )press link "([^"]*)"$/ do |link|
  click_link(link)
end

And /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

And /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end


Given /I login as "(.*)"/ do |name|
  step %{I am on the login page}
  step %{I fill in "username" with "#{Tutee.find_by_first_name(name).email}"}
  step %{I fill in "password" with "topsecret"}
  step %{press "Log in"}
end

# When /^(?:|I )try to access "([^"]*)"'s (.+)$/ do |tutee_first_name, page_name|
#   # requested_uri = URI.parse(current_url)
#   # expect(current_uri).eq(tutees/10)
#   other_profile = Tutee.find_by_first_name(tutee_first_name)
#   other_profile_id = Tutee.find(other_profile).id
#   bad_url = "/tutees/"
#
#   good_url = browser.get()
#   req_url = browser.refresh()
#   assert_equal (bad_url)
# end
#
Given /^a valid tutee$/ do
  @user = Tutee.create!({
                           email: 'bobburgers@berkeley.edu',
                           password: 'topsecret',
                           password_confirmation: 'topsecret',
                           first_name: 'Bob',
                           last_name: 'Burgers',
                           birthdate: '1992-01-01',
                           sid: 123456789,
                           confirmed_at: Time.now
                       })
end

Given /^a logged in user$/ do
  Given "a valid user"
  visit signin_url
  fill_in "Email", :with => "minikermit@hotmail.com"
  fill_in "Password", :with => "12345678"
  click_button "Sign in"
end

Given /^an unconfirmed tutee$/ do
  @tutee = Tutee.create!({
                            email: 'bobby@berkeley.edu',
                            password: 'topsecret',
                            password_confirmation: 'topsecret',
                            first_name: 'Bob',
                            last_name: 'Burgers',
                            birthdate: '1992-01-01',
                            sid: 123456789,
                        })
end


