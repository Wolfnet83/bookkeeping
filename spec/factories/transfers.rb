FactoryGirl.define do
  factory :transfer do
    association :from_account, factory: :funded_account
    association :to_account, factory: :funded_dc_account
    user
    amount 1
  end
end
