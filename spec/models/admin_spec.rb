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


end
