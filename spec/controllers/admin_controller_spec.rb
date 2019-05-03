require 'rails_helper'
require 'capybara/rspec'

RSpec.describe AdminsController, type: :controller do
  before :each do
    @admin = Admin.create(:password=>"oski", :current_semester=>"Spring2019", :statistics_semester=>"Spring2019")
  end

end
