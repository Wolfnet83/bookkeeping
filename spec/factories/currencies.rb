FactoryGirl.define do
  factory :currency do
    name "Dollar US"
    abbr_name "USD"
    exchange_rate "19.91"

    factory :default_currency do
      name "Moldavian Lei"
      abbr_name "MDL"
      exchange_rate "1.0"
      default_currency true
    end
  end
end
