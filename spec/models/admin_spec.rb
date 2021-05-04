require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject {
    Admin.new(password_digest: 'thisIsPassWord')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "has a master admin index number" do
    expect(Admin.master_admin_index).not_to be_nil
  end

end
