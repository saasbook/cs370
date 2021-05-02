require 'rails_helper'
require 'rspec-rails'
require 'capybara/rspec'

RSpec.describe Tutees::RegistrationsController, type: :controller do
	before do
	    @request.env['devise.mapping'] = Devise.mappings[:tutee]
	end
	it "after_update_path_for" do
		@tutee = FactoryBot.create(:tutee)
		controller.after_update_path_for(@tutee).should eq tutee_path(@tutee)
	end
end
