require 'rails_helper'
require 'spec_helper'

RSpec.describe EvaluationsController, type: :controller do
  before :each do
    @tutee = Tutee.create(:id => 1, :sid => 123456789, :first_name => "Bob", :last_name => "Burgers", :email => "bobs@berkeley.edu", :birthdate => "1992-01-01", :privilege => 'No', :gender => 'male',
              :ethnicity => 'Asian', :dsp => 'Yes', :transfer => 'Yes', :year => '4 years', :pronoun => 'he/his', :major => 'EECS')
    @tutor = Tutor.create(:id => 1, :type_of_tutor => "20 hour TA", :grade_level => 'Junior', :first_name => 'Bart', :last_name => 'Simpson', :email => 'bart@berkeley.edu')
    @course = Course.create(:id => 1, :course_num => 1, :name => "CS61A", :semester => "Sp2019")
    @request = Request.create(:id => 1, :tutee_id => 1, :course_id => 1, :subject => "tree")
    @meeting = Meeting.create(:id => 1, :tutor_id => 1, :request_id => 1, :evaluation_id => 1)
    @evaluation = double("Evaluation", :id => 1, :final_comments => 'woopdy di scoop woop', :status => 'Pending')
  end
  describe 'index page of pending evaluation' do
    it 'generate a route to show pending evaluations' do
      expect({:get => tutee_evaluations_path(1)}).to route_to(:controller => "evaluations", :action => "index", :tutee_id => "1")
    end
    it 'should render the template to show all pending evaluations' do
      visit tutee_evaluations_path(@tutee)
      expect(response).to have_http_status(:success)
    end
  end
end
