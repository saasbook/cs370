require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do
  describe "show history" do
    before :each do
       @m = create(:request)
    end
    it "it should generate routing for history" do
      {:get => request_history_tutee_path(1)}.
      should route_to(:controller => "requests", :action => "history", :tutee_id => "1")
    end
    it "it should call a correct method history" do
      Request.should_receive(:where).with(:tutee_id => "1")
      get :history,  params: {:tutee_id => "1"}
    end

    it "makes the history results available to that template" do
      Request.should_receive(:where).with(:tutee_id => "1")
      get :history,  params: {:tutee_id => "1"}
      response.should render_template("history")
    end
  end

  describe "create tutoring request" do
    before :each do
      @tutee = double("Tutee", :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    end

    it "has a tutee_id" do
      expect(@tutee.sid).not_to be_nil
    end

    # it 'should create a new request' do
      # @oski = create(:request)
      # visit new_tutee_request_path(@tutee)
      # expect(page.find(:xpath, '//*[@id="request_subject"]')).not_to be_nil
      # expect(find_by_id('request_subject')).to be_nil
      # fill_in "request_subject", with: "Ruby on Rails"
      #
      # expect { click_button "Request Tutor" }.to change(Request, :count).by(1)

    # end

  end

end