Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |request|
    Request.create request
  end
end
