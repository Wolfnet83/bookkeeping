# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  from_account_id :integer
#  to_account_id   :integer
#  amount          :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  amount_in_dc    :decimal(10, 2)   default(0.0)
#

FactoryBot.define do
  factory :transfer do
    association :from_account, factory: :funded_account
    association :to_account, factory: :funded_dc_account
    user
    amount { 1 }
  end
end
