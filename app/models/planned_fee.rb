class PlannedFee < ApplicationRecord
  validates :name, :user_id, :currency_id, presence: true

  belongs_to :user
  belongs_to :currency

  scope :this_month,-> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  scope :unpaid,-> { where(status: PLANNED_FEE_STATUSES[:unpaid]) }
  
  def paid?
    status == PLANNED_FEE_STATUSES[:paid].to_i
  end
end
