Given /the following tutors exist/ do |tutors_table|
  tutors_table.hashes.each do |tutor|
    Tutor.create tutor
  end
end
