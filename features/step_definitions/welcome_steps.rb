When /I want to log in as user type "(.*)"/ do |user_type|
  step %{I am on the home page}
  step %{ajax has loaded}
  step %{I select "#{user_type}" from "user_type"}
  step %{ajax has loaded}
end

Given /I log in as admin/ do
  step %{I want to log in as user type "Admin"}
  step %{I fill in "password" with "#{Admin.general_seed_password}"}
  step %{press "Log in"}
end

Given /I log in as "(.*)" "(.*)"/ do |user_type, name|
  step %{I want to log in as user type "#{user_type}"}
  if user_type == "Tutee"
    step %{I fill in "username" with "#{Tutee.find_by_last_name(name).email}"}
  elsif user_type == "Tutor"
    step %{I fill in "username" with "#{Tutor.find_by_last_name(name).email}"}
  end
  step %{I fill in "password" with "#{Admin.general_seed_password}"}
  step %{press "Log in"}
end
