require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do
  describe "show history" do
    before :each do
    end
  end

  describe "GET requests#new" do
    before :each do
      @tutee = FactoryBot.create(:tutee)
    end

    it 'should go to :new requests' do
      visit new_tutee_request_path(@tutee.id)
      expect(response).to have_http_status(:success)
    end

  end



end
