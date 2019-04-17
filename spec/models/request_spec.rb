require 'rails_helper'

RSpec.describe Request, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    # @request = double("Request", :tutee_id => 1, :course_id => 1, :subject => "tree")
    # @request = Request.new(:tutee_id => 1, :course_id => 1, :subject => "tree")
    @course = create(:course)
    @tutee = create(:tutee)
    # @request = create(:request, :tutee_id => @tutee.id, :course_id => @course.id, :subject => "tree")
    @request = create(:request, :tutee => @tutee, :course => @course, :subject => "tree")
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
    expect(@request.tutee_id).to eq(@tutee.id)
  end
  it "could find a correct course_id" do
    expect(@request.course_id).to eq(@course.id)
  end
  it "could find a correct subject"do
    expect(@request.subject).to eq("tree")
  end
  it 'requires a tutee parameter' do
    expect { create(:request, tutee: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'has a course' do
    expect(@request.course).not_to be_nil
  end

  # it 'requires a course parameter' do
  #   expect { create(:request, course: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  # end
  #
  # it 'requires a request parameter' do
  #   expect { create(:meeting, request: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  # end

end