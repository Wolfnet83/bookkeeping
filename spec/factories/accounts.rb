# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  name        :string
#  funds       :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  currency_id :integer
#  funds_in_dc :decimal(10, 2)   default(0.0)
#  active      :boolean          default(TRUE)
#  deposit     :boolean          default(FALSE)
#

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
