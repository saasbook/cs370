require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do
  describe "show history" do
    before :each do
      # @m = double("Request", :tutee_id => 1, :course_id => 1, :subject => "tree")
       @m = create(:request)
    end
    it "it should generate routing for history" do
      {:get => request_history_tutee_path(1)}.
      should route_to(:controller => "requests", :action => "history", :tutee_id => "1")
    end
    it "it should call a correct method history" do
      # expect(Request).to receive(:history).with('1')
      # get :show, {:id => "1"}
      Request.should_receive(:where).with(:tutee_id => "1")
      
      # Request.should_receive(:find).with('1')
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
      @oski = double("Tutee", :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    end
    it "it should generate routing for tutee" do
      {:get => tutee_homepage_path(1)}.
          should route_to(:controller => "tutees", :action => "show", :id => "1")
    end

  end
end