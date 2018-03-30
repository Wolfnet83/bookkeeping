# == Schema Information
#
# Table name: planned_fee_templates
#
#  id          :integer          not null, primary key
#  name        :string
#  amount      :decimal(10, 2)   default(0.0)
#  active      :boolean          default(TRUE)
#  currency_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :planned_fee_template do
    
  end
end
