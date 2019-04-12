require 'rails_helper'

RSpec.describe TuteesController do
  describe "GET #index" do
    it "redirects to new"
  end

  describe "GET #show" do
    it "renders the :show template"
    it "displays correct username"
  end

  describe "GET #new" do
    it "assigns a new tutee to @tutee"
    it "renders the :new template"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database"
      it "redirects to the home page"
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :new template"
    end
  end
end
