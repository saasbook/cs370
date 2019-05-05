require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do
  describe "show history" do
    before :each do
       @m = create(:request)
    end
    it 'should generate routing for history' do
      {:get => request_history_tutee_path(1)}.
      should route_to(:controller => "requests", :action => "history", :tutee_id => "1")
    end
    it 'should call a correct method history' do
      Request.should_receive(:where).with(:tutee_id => "1")
      get :history,  params: {:tutee_id => "1"}
    end

    it "makes the history results available to that template" do
      Request.should_receive(:where).with(:tutee_id => "1")
      get :history,  params: {:tutee_id => "1"}
      response.should render_template("history")
    end
  end

  describe "GET requests#new" do
    before :each do
      @tutee = double("Tutee", :id=>1, :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    end

    it 'should go to :new requests' do
      visit new_tutee_request_path(@tutee.id)
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST requests#create" do
    before :each do
      @tutee = double("Tutee", :id=>1, :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    end

    it "it should go to :create requests" do
      visit tutee_requests_path(@tutee.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET request#email" do
    before :each do
      @tutee = create(:tutee)
      @tutor = create(:tutor)
      @m = create(:request) #@request is protected word for Cookies 
    end
    it "should create a new meeting object" do 
      Meeting.should_receive(:create).with(:tutor_id => 1, :request_id => 1)
      get :email, params: {:tutor_id => 1, :student => { :id => Tutee.all.first.id, :requestid => 1 }, :tutor => {:text_area => "hi"}}
    end
  end

  describe "Request" do

    before :each do
      @tutee = create(:tutee)
      @tutor = create(:tutor)
      @m = create(:request) #@request is protected word for Cookies 
    end

    it "sent email" do 
      expect(ActionMailer::Base.deliveries.length).to eq(1)
    end 

  end

end