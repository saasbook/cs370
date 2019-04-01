Given /the following tutors exist/ do |tutors_table|
  tutors_table.hashes.each do |tutor|
    Tutor.create tutor
  end
end

Then /I should see all the tutors/ do
  # Make sure that all the movies in the app are visible in the table
  Tutor.all.each do |tutor|
    step %{I should see "#{tutor.firstname}", "{tutor.lastname}"}
  end
end