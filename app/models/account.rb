class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :funds, numericality: true

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
