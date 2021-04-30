Given /the following tutees exist/ do |tutees_table|
  tutees_table.hashes.each do |tutee|
    Tutee.create tutee
  end
end
