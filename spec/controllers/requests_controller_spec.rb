require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do
  describe "show history" do
    before :each do
      @m = create(:request)
      @tutee = Tutee.create(:sid => 123456789, :first_name => "Bob", :last_name => "Burgers", :email => "bobbie@berkeley.edu", :birthdate => "1992-01-01", :privilege => 'No', :gender => 'male',
                             :ethnicity => 'Asian', :dsp => 'Yes', :transfer => 'Yes', :year => '4 years', :pronoun => 'he/his', :major => 'EECS', :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)

    end
    # it 'should generate routing for history' do
    #   {:get => request_history_tutee_path(1)}.
    #   should route_to(:controller => "requests", :action => "history", :tutee_id => "1")
    # end
    # it 'should call a correct method history' do
    #   Request.should_receive(:where).with(:tutee_id => "1")
    #   get :history,  params: {:tutee_id => "1"}
    # end
    #
    # it "makes the history results available to that template" do
    #   Request.should_receive(:where).with(:tutee_id => "1")
    #   get :history,  params: {:tutee_id => "1"}
    #   response.should render_template("history")
    # end
  end

  describe "GET requests#new" do
    before :each do
      @tutee = create(:tutee, :sid=>3033298504, :first_name=>"an", :email=>"an.ju@berkeley.edu", :privilege=>'No',:password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
    end

    it 'should go to :new requests' do
      visit new_tutee_request_path(@tutee.id)
      expect(response).to have_http_status(:success)
    end

  end



end
