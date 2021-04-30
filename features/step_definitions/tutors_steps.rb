Given /the following tutors exist/ do |tutors_table|
  tutors_table.hashes.each do |tutor|
    Tutor.create tutor
  end
end

Given /the following berkeley_classes exist/ do |berkeley_classes_table|
  berkeley_classes_table.hashes.each do |berkeley_class|
    BerkeleyClass.create berkeley_class
  end
end

When /I log out as tutor/ do
  #This is kind of gross but it's literally what they left us
  find(:xpath,"/html/body/div/div[1]/a").click
end
