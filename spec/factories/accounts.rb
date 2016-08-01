FactoryGirl.define do
  factory :account do |f|
    f.name  { Faker::Name.name }
    f.sfid  { Faker::Number.number(10) }
  end

  def get_account_by_sfid(sfid)
    Account.where(sfid: sfid).first || Factory(:account, sfid: sfid)
  end
end