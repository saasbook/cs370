require 'rails_helper'
require 'rspec-rails'
require 'capybara/rspec'

RSpec.describe TuteesController, type: :controller do
  before :each do
    # @tutee = double("Tutee", :id=>1, :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    @tutee = Tutee.create(:sid=>1234567, :first_name=>"an", :email=>"an.ju@berkeley.edu", :birthdate => "1992-01-01", :last_name => "ju", :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
  end

  describe "GET #index" do
    before :each do
      @tutee = FactoryBot.build(:tutee)
      if Tutee.find_by_email(@tutee.email)
        @tutee = Tutee.find_by_email(@tutee.email)
      else
        @tutee = FactoryBot.create(:tutee)
      end
    end
    it "signs me in" do
      visit new_tutee_session_path
      expect(response).to have_http_status(:success)
    end
    it "without existing account renders :new template" do 
      visit new_tutee_session_path
      expect(response).to have_http_status(:success)
    end
    it "with existing account renders :show template" do 
      visit tutee_path(@tutee)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "assigns courses" do
      courses = [Course.find_by_semester(Course.current_semester)]
      get :show, {:params => {:id => @tutee.id, :tutee_id => @tutee.id}, :session => {:tutee_id => @tutee.id}}
      assigns(:courses).should eq(courses)
    end

    it "assigns tutee" do
      get :show, {:params => {:id => @tutee.id, :tutee_id => @tutee.id}, :session => {:tutee_id => @tutee.id}}
      assigns(:tutee).should eq(@tutee)
    end
  end

  describe "POST #login" do
    it "renders the :show template"
    it "displays correct username"
  end

  describe "GET #edit" do
    it "renders the :edit template" do
      visit edit_tutee_registration_path(@tutee)
      expect(response).to have_http_status(:success)
    end
    it "retrieves correct tutee information" do
      expect(@tutee.first_name).to eq 'an'
      expect(@tutee.last_name).to eq 'ju'
      expect(@tutee.sid).to eq 1234567
      expect(@tutee.email).to eq 'an.ju@berkeley.edu'
      expect(@tutee.birthdate).to eq DateTime.strptime('1992-01-01','%Y-%m-%d')
      expect(@tutee.password).to eq 'topsecret'
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      visit new_tutee_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database" do
        @tutee = Tutee.find_by_email("an.ju@berkeley.edu")
        expect(@tutee.first_name).to eq 'an'
        expect(@tutee.last_name).to eq 'ju'
        expect(@tutee.sid).to eq 1234567
        expect(@tutee.email).to eq 'an.ju@berkeley.edu'
        expect(@tutee.birthdate).to eq DateTime.strptime('1992-01-01','%Y-%m-%d')
      end
      it "given valid inputs renders :show template" do 
        visit tutee_path(@tutee)
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do 
        Tutee.create(:email=>"test@berkeley.edu")
        expect(Tutee.find_by_email("test@berkeley.edu")).to eq nil
      end
      it "re-renders the :new template" do 
        visit new_tutee_session_path
        expect(response).to have_http_status(:success)
      end
      it "is invalid without first name" do 
        Tutee.create(:sid=>1234567, :email=>"test@berkeley.edu", :birthdate => "1992-01-01", :last_name => "ju", :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
        expect(Tutee.find_by_email("test@berkeley.edu")).to eq nil
      end
      it "is invalid without sid"
      it "is invalid without email"
      it "is invalid without @berkeley.edu email"
      it "is invalid without birthdate"
      it "is invalid without proper birthdate format"
      it "is invalid if the birthdate is in the future" do
        Tutee.create(:sid=>1234567, :email=>"test@berkeley.edu", :birthdate => "9999-01-01", :last_name => "ju", :password => 'topsecret', :password_confirmation => 'topsecret', :confirmed_at => Time.now)
        expect(Tutee.find_by_email("test@berkeley.edu")).to eq nil
      end
    end
  end
  describe "PUT #update" do
    context "with valid attributes" do
      it "saves the new contact in the database"
      it "redirects to the home page"
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :edit template"
      it "is invalid without first name"
      it "is invalid without sid"
      it "is invalid without email"
      it "is invalid without @berkeley.edu email"
      it "is invalid without birthdate"
      it "is invalid without proper birthdate format"
      it "is invalid if the birthdate is in the future"
    end
  end
end
