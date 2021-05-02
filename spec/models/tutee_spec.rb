require 'rails_helper'

RSpec.describe Tutee, type: :model do
  it "creates a new tutee" do
	@tutee = Tutee.create(:sid=>1234567, :first_name=>"an", :email=>"an.ju@berkeley.edu", :last_name => "ju", :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
	expect(@tutee).not_to be_nil
  end
end
