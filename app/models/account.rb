class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :funds, numericality: { greater_than_or_equal_to: 0}

  has_many :transactions, dependent: :destroy

  def plus(amount)
    amount ||= 0
    update_attribute :funds, funds + amount
  end

  def minus(amount)
    amount ||= 0
    update_attribute :funds, funds - amount
  end
end
