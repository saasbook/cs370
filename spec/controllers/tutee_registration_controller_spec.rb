require 'rails_helper'
require 'rspec-rails'
require 'capybara/rspec'

RSpec.describe Tutees::RegistrationsController, type: :controller do
	before do
	    @request.env['devise.mapping'] = Devise.mappings[:tutee]
	end
	it "after_update_path_for" do
		@tutee = Tutee.create!(:sid=>1234567, :first_name=>"an", :email=>"an.ju@berkeley.edu", :birthdate => "1992-01-01", :last_name => "ju", :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
		controller.after_update_path_for(@tutee).should eq tutee_path(@tutee)
	end
end