require 'rails_helper'

RSpec.describe Meeting, type: :model do
  fixtures :evaluations, :meetings
  #let(:meeting) { create(:meeting) }

  it 'has a tutor' do
    meeting = Meeting.find(20)
    @tutor1 = FactoryBot.create(:tutor, :id => 20)
    expect(meeting.tutor).not_to be_nil
  end


  it 'has a request' do
    meeting = Meeting.find(20)
    expect(meeting.request).to be_nil
  end


end
