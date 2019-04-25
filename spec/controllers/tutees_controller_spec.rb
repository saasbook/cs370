require 'rails_helper'
require 'capybara/rspec'

RSpec.describe TuteesController, type: :controller do
  before :each do
    # @tutee = double("Tutee", :id=>1, :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    @tutee = Tutee.create(:sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
  end

  describe "GET #index" do
    before :each do
      @tutee = create(:tutee)
    end
    it "signs me in" do
      visit tutees_path

    end
    it "without existing account renders :new template"
    it "with existing account renders :show template"
  end

  describe "GET #show" do
    it "renders the :show template" do
      visit tutee_path(@tutee)
      expect(response).to have_http_status(:success)
    end

    it "displays correct username"
  end

  describe "POST #login" do
    it "renders the :show template"
    it "displays correct username"
  end

  describe "GET #edit" do
    it "renders the :edit template" do
      visit edit_tutee_path(@tutee)
      expect(response).to have_http_status(:success)
    end
    it "retrieves correct tutee information"
  end

  describe "GET #new" do
    it "renders the :new template"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database"
      it "given valid inputs renders :show template"
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :new template"
      it "is invalid without first name"
      it "is invalid without first name"
      it "is invalid without sid"
      it "is invalid without email"
      it "is invalid without @berkeley.edu email"
      it "is invalid without birthdate"
      it "is invalid without proper birthdate format"
      it "is invalid if the birthdate is in the future"
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
