Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    #ethnicity is an array, split on spaces, no commas
    user['ethnicity'] = user['ethnicity'].split(' ')
    User.create! user
  end
end

When /I log in with email "(.*)" and password "(.*)"/ do |email,password|
  step %{I am on the home page}
  step %{I fill in "username" with "#{email}"}
  step %{I fill in "password" with "#{password}"}
  step %{press "Log in"}
end
