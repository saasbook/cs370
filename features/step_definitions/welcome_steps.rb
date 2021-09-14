When /I want to log in as user type "(.*)"/ do |user_type|
  step %{I am on the home page}
  step %{ajax has loaded}
  step %{I select "#{user_type}" from "user_type"}
  step %{ajax has loaded}
end
