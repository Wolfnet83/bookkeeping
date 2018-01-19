FactoryBot.define do
  factory :account do
    name "Test account"
    currency

    factory :funded_account do
      funds 10
    end

    factory :funded_dc_account do
      funds 1000
      association :currency, factory: :default_currency
    end
  end
end
