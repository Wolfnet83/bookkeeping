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

require 'rails_helper'

RSpec.describe PlannedFeeTemplate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
