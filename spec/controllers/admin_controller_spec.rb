require 'rails_helper'
require 'capybara/rspec'

RSpec.describe AdminsController, type: :controller do
	describe "get current semester" do
		it "both admin and course doesn't exist" do
			expect(Admin.current_semester).to eq(nil)
		end
		context "admin exists" do
			before :each do
				@admin = Admin.create(id: 1, :password=>"oski", :current_semester=>"Spring2019", :statistics_semester=>"Spring2019")
			end
			it "formatted current semester" do
				expect(Admin.current_semester_formatted).to eq("Spring 2019")
			end
			it "statistics semester" do
				expect(Admin.statistics_semester).to eq("Spring2019")
			end
			it "formatted statistics semester" do
				expect(Admin.statistics_semester_formatted).to eq("Spring 2019")
			end
		end
	end
end
