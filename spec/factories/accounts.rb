FactoryGirl.define do
  factory :account do
    name "Test account"

    factory :funded_account do
      funds 10
    end
    
  end
end
