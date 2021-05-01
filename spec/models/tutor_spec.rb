require 'rails_helper'

RSpec.describe Tutor, type: :model do
  it "creates a new tutor" do
	@tutor = Tutor.create(:type_of_tutor => "20 hour TA", :term => '4', :first_name => 'Bart', :last_name => 'Simpson', :email => 'bart@berkeley.edu')
	expect(@tutor).not_to be_nil
  end
end
