class Account < ActiveRecord::Base
  validates :name, :currency_id, presence: true
  validates :funds, numericality: { greater_than_or_equal_to: 0 }

  has_many :transactions, dependent: :destroy
  has_many :transfers, as: :from_account
  has_many :transfers, as: :to_account

  belongs_to  :currency

  def plus(amount, amount_in_dc)
    amount ||= 0
    update_attributes(funds: funds + amount,
                      funds_in_dc: funds_in_dc + amount_in_dc)
  end

  def minus(amount, amount_in_dc)
    amount ||= 0
    update_attributes(funds: funds - amount,
                      funds_in_dc: funds_in_dc - amount_in_dc)
  end

  def account_label
    name.to_s + " (" + funds.to_s + ")"
  end

  def self.calculate_accounts_in_default_currency
    Account.all.each do |account|
      if account.currency.present?
        account.funds_in_dc = account.funds * account.currency.exchange_rate
        account.save!
      end
    end
  end

  def self.set_default_currency
    Account.all.each do |account|
      account.currency = Currency.default_currency if account.currency.blank?
      account.save!
    end
  end
end
