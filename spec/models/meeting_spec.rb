require 'rails_helper'

RSpec.describe Meeting, type: :model do
  fixtures :evaluations, :meetings
  #let(:meeting) { create(:meeting) }

  it 'has a tutor' do
    meeting = Meeting.find(20)
    @tutor1 = FactoryBot.create(:tutor, :id => 20)
    expect(meeting.tutor).not_to be_nil
  end

  it 'requires a tutor parameter' do
    expect { FactoryBot.create(:meeting, id: 50, tutor: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'has a request' do
    meeting = Meeting.find(20)
    expect(meeting.request).to be_nil
  end

  it 'requires a request parameter' do
    expect { create(:meeting, id: 50, request: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end


end
