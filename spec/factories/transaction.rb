FactoryGirl.define do
  factory :transaction do
    association :account, factory: :funded_account
    category
    user
    amount 5
  end
end
