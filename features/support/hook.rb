Before do |scenario|
  #anything you want to do before every scenario, put it here.
  Rails.application.load_seed
  puts "db/seeds.rb has been seeded."

end
