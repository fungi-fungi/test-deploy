require 'rails_helper'

RSpec.describe Account, type: :model do
  
  it "has a valid factory" do
    expect(build(:account)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:account, name: nil)).not_to be_valid
  end

  it "is invalid without sfid" do
    expect(build(:account, sfid: nil)).not_to be_valid
  end

  it "can be saved" do
    old_size = Account.all.size
    create(:account)
    expect(Account.all.size).to eq(old_size + 1)
  end

end