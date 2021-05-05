Before do |scenario|
  #Use FactoryBot to create a default repository of users for easy reading, naming syntax should be self-documenting
  #so you don't need the table syntax to see what's relevant to each test.
  FactoryBot.create(:admin)
  FactoryBot.create(:tutee_default)
  FactoryBot.create(:tutor_default)
  puts "db/seeds.rb has been seeded."
end
