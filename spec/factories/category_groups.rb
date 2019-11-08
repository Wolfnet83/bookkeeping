# == Schema Information
#
# Table name: category_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :category_group do
    name { "Test category group" }
  end
end
