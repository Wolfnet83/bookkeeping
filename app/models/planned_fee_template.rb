class PlannedFeeTemplate < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :currency

  scope :active,-> { where(active: true) }

  def self.create_monthly_fees
    PlannedFeeTemplate.active.each do |pft|
      pf = PlannedFee.this_month.where(name: pft.name, user_id: pft.user_id)
      if pf.empty?
        pf = PlannedFee.create(name: pft.name, amount: pft.amount, currency_id: pft.currency_id, user_id: pft.user_id)
      end
    end
  end
end
