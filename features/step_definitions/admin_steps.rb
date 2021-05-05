Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    Admin.create admin
  end
end

Given /signups are off/ do
  Admin.find(Admin.master_admin_index).update(signups_allowed: false)
end

Then /I should see courses "(.*)"/ do |course_list|
  course_list.to_s.split(", ").each do |course_name|
    expect(page).to have_content(course_name)
  end
end

Then /I should not see courses "(.*)"/ do |course_list|
  course_list.to_s.split(", ").each do |course_name|
    expect(page).to have_no_content(course_name)
  end
end

When /I update courses to "(.*)"/ do |course_list|
  # separate course list into a newline separated list rather than comma separated
  fill_in 'course_list', :with => course_list.to_s.gsub(/, /, "\r\n")
end

When /I update admin password with password "(.*)" and confirmation password "(.*)"/ do |pass, confirmation|
  page.find(:xpath, '//*[@id="update_password_password"]').set(pass)
  page.find(:xpath, '//*[@id="update_password_password_confirmation"]').set(confirmation)
  click_button("update_password")
end

Then /I can see tutor "(.*)" with tutor hours (.*)/ do |first,num|
  expect(page).to have_content(first)
  expect(page).to have_content(num)
end

Then /I can see the tutor name "(.*)"/ do |name|
  expect(page).to have_content(name)
end

Then /I can see the composite score of "(.*)"/ do |score|
  expect(page).to have_content(score)
end

Then /I can see sids "(.*)"/ do |sid_list|
  sid_list.to_s.split(", ").each do |sid|
    expect(page).to have_content(sid)
  end
end
Then /I can not see sid "(.*)"/ do |sid|
  expect(page).to have_no_content(sid)
end
