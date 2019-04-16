# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
tutees = [{:sid => 1, :first_name => "Bob", :last_name => "Burgers", :email => "bobburgers@berkeley.edu.com", :birthdate => "1992-01-01" }]
tutees.each do |tutee|
  Tutee.create!(tutee)
end