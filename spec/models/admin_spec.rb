require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject {
    Admin.new(password_digest: 'thisIsPassWord', current_semester: 'Sp2019', statistics_semester: 'Sp2019')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "has a current semester" do
    expect(subject.current_semester).not_to be_nil
  end

  it "has a statistic semester" do
    expect(subject.statistics_semester).not_to be_nil
  end

  it "has a master admin index number" do
    expect(Admin.master_admin_index).not_to be_nil
  end

  it "has a list of possible semester" do
    expect(Admin.semester_possibilities).not_to be_nil
  end

  it "has a valid semester year" do
    expect(Admin.validate_year("2019")).not_to be_nil
  end

  it "return nil if given invalid semester year" do
    expect(Admin.validate_year("DefinitelyNotValidYear")).to be_nil
  end

end
