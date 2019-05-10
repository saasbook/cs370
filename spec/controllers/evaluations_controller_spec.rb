require 'rails_helper'
require 'spec_helper'

RSpec.describe EvaluationsController, type: :controller do
  before :each do
    @tutee = Tutee.create(:sid=>1234567, :first_name=>"an", :email=>"an.ju@berkeley.edu", :birthdate => "1992-01-01", :last_name => "ju", :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
    @tutor = Tutor.create(:id => 1, :type_of_tutor => "20 hour TA", :grade_level => 'Junior', :first_name => 'Bart', :last_name => 'Simpson', :email => 'bart@berkeley.edu')
    @course = Course.create(:id => 1, :course_num => 1, :name => "CS61A", :semester => "Sp2019")
    @request = Request.create(:id => 1, :tutee_id => 1, :course_id => 1, :subject => "tree")
    @meeting = Meeting.create(:id => 1, :tutor_id => 1, :request_id => 1, :evaluation_id => 1)
    @evaluation = double("Evaluation", :id => 1, :final_comments => 'woopdy di scoop woop', :status => 'Pending', :hash_id => 123)
  end
  describe 'index page of pending evaluation' do
    it 'generate a route to show pending evaluations' do
      expect({:get => tutee_evaluations_path(1)}).to route_to(:controller => "evaluations", :action => "index", :tutee_id => "1")
    end
    # it 'should render the template to show all pending evaluations' do
    #   visit tutee_evaluations_path(@tutee)
    #   expect(response).to have_http_status(:success)
    # end
  end
  describe 'public edit' do
    it 'generate a route to edit public' do
      expect({:get => edit_evaluation_path(123)}).to route_to(:controller => "evaluations", :action => "public_edit", :id => "123")
    end
    it 'should render the template to show evaluation public edit' do
      visit edit_evaluation_path(@evaluation)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'public show' do
    it 'generate a route to show public' do
      expect({:get => evaluation_public_path(123)}).to route_to(:controller => "evaluations", :action => "public_show", :id => "123")
    end
    it 'should render the template to show public' do
      visit  evaluation_public_path(@evaluation)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'inside show' do
    it 'generate a route to show inside' do
      expect({:get => tutee_evaluation_path(1,1)}).to route_to(:controller => "evaluations", :action => "show", :tutee_id => "1", :id => "1")
    end
    it 'should render the template to show' do
      visit  tutee_evaluation_path(@tutee, @evaluation)
      expect(response).to have_http_status(:success)
    end
  end
  describe 'pending_evaluation' do
    it 'generate a route to show inside' do
      expect({:get => tutee_evaluation_path(1,1)}).to route_to(:controller => "evaluations", :action => "show", :tutee_id => "1", :id => "1")
    end
    it 'should render the template to show' do
      visit  tutee_evaluation_path(@tutee, @evaluation)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'update public' do
    it 'generate a route to update successfully' do
        expect({:put => evaluation_path(1)}).to route_to(:controller => "evaluations", :action => "update", :id => "1")
    end
    it 'should render the template to finish update' do
      visit  evaluation_path(@evaluation)
      expect(response).to have_http_status(:success)
    end
    it 'generate a route to update unsuccessfully' do
        expect({:get => edit_evaluation_path(1)}).to route_to(:controller => "evaluations", :action => "public_edit", :id => "1")
    end
    it 'should render the template to keep update' do
      visit  edit_evaluation_path(@evaluation)
      expect(response).to have_http_status(:success)
    end
  end
end
