Given /the following meetings exist/ do |meetings_table|
  meetings_table.hashes.each do |meet|
    Meeting.create meet
  end
end

Given /the following evaluations exist/ do |evaluations_table|
  evaluations_table.hashes.each do |eval|
    Evaluation.create eval
  end
end

Then /can see my evaluation form with course name (.*)/ do |name|
  page.should have_content(name)
end

Then /can see my evaluation form with tutor name (.*)/ do |name|
  page.should have_content(name)
end

Then /can see my evaluation form with status(.*)/ do |name|
  page.should have_content(name)
end

Given /I was given the page with evaluation hash id "(.*)"/ do |hash|
  # p Evaluation.all
  @tutors = Tutor.all
  p @tutors
  @tutees = Tutee.all
  p @tutees
  @evaluation = Evaluation.all
  p @evaluation

end
