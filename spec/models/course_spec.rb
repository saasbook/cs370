require 'rails_helper'

RSpec.describe Course, type: :model do
  subject {
    Course.new(course_num: 3, name: 'CS169', semester: 'Sp2019')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "has a name" do
    expect(subject.name).not_to be_nil
  end

  it "has a semester" do
    expect(subject.semester).not_to be_nil
  end

  it "has a course number" do
    expect(subject.course_num).not_to be_nil
  end

  it "has current semester" do
    expect(Course.current_semester).not_to be_nil
  end

end
