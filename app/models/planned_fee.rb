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

class PlannedFee < ApplicationRecord
  validates :name, :user_id, :currency_id, presence: true

  belongs_to :user
  belongs_to :currency

  scope :this_month,-> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :unpaid,-> { where(status: PLANNED_FEE_STATUSES[:unpaid]) }
  
  self.per_page = 10

  def paid?
    status == PLANNED_FEE_STATUSES[:paid].to_i
  end

  def amount_in_dc
    amount * currency.exchange_rate
  end
end
