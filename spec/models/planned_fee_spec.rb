# == Schema Information
#
# Table name: planned_fees
#
#  id          :integer          not null, primary key
#  name        :string
#  amount      :decimal(10, 2)   default(0.0)
#  status      :integer          default(0)
#  currency_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe PlannedFee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
