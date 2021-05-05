Before do |scenario|
  #Seed the db/seeds.rb file before every single scenario. This will FORCE us to keep the seeds clean and necessitate that we update our tests if they break something.

  Rails.application.load_seed
  puts "db/seeds.rb has been seeded."
end
