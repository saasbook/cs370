Given /the following tutees exist/ do |tutees_table|
  tutees_table.hashes.each do |tutee|
    #ethnicity is an array, split on spaces, no commas
    tutee['ethnicity'] = tutee['ethnicity'].split(' ')
    Tutee.create! tutee
  end
end
