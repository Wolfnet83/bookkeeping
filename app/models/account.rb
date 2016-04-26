class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :funds, numericality: { greater_than_or_equal_to: 0 }

  has_many :transactions, dependent: :destroy
  has_many :transfers, as: :from_account
  has_many :transfers, as: :to_account
  
  belongs_to  :currency

  def plus(amount)
    amount ||= 0
    update_attributes(funds: funds + amount)
  end

  def minus(amount)
    amount ||= 0
    update_attributes(funds: funds - amount)
  end
end
