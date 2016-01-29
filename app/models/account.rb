class Account < ActiveRecord::Base
  validates :name, presence: true

  has_many :transactions

  def plus(amount)
    amount ||= 0
    update_attribute :funds, funds + amount
  end

  def minus(amount)
    amount ||= 0
    update_attribute :funds, funds - amount
  end
end
