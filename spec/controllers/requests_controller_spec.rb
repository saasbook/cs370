require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
  describe "show history" do
    before :each do
      @m = double("Request", :tutee_id => 1, :course_id => 1, :subject => "tree")
    end
    it "it should generate routing for history" do
      {:get => 'requests/history/1'}.
      should route_to(:controller => "requests", :action => "history", :tutee_id => "1")
    end
    # it "it should call a correct method history" do
    #   # expect(Request).to receive(:history).with('1')
    #   # get :show, {:id => "1"}
    #   Request.should receive(:find).with(1)
    #   get :history, {:tutee_id => 1}
    # end
    it "makes the history results available to that template" do
      Request.stub(:find).with('1')
      get :history, {:tutee_id => "1"}
      response.should render_template('history')
    end
  end
end
