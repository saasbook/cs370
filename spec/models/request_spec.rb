require 'rails_helper'
require 'spec_helper'

RSpec.describe Request, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    # @request = double("Request", :tutee_id => 1, :course_id => 1, :subject => "tree")
    @request = Request.new(:tutee_id => 1, :course_id => 1, :subject => "tree")
  end
  # describe "view my history request" do
  #   it "start with correct tutee and tutee's info" do
  #     expect(@request.tutee_id).to eq(1)
  #     expect(@request.course_id).to eq(1)
  #     expect(@request.subject).to eq "tree"
  #   end
  # end
  it "has a tutee_id" do
    expect(@request.tutee_id).not_to be_nil
  end
  it "could find a correct tutee id" do
    expect(@request.tutee_id).to eq(1)
  end
  it "could find a correct course_id" do
    expect(@request.course_id).to eq(1)
  end
  it "could find a correct subject"do
    expect(@request.subject).to eq("tree")
  end
end
