require 'rails_helper'

RSpec.describe Request, type: :model do
  before(:each) do
    @course = create(:course)
    @tutee = FactoryBot.build(:tutee)
    if Tutee.find_by_email(@tutee.email)
      @tutee = Tutee.find_by_email(@tutee.email)
    else
      @tutee = FactoryBot.create(:tutee)
    end

    @request = create(:request, :tutee => @tutee, :course => @course, :subject => "tree")
  end

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

end