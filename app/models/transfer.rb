class Transfer < ActiveRecord::Base
  validates :from_account_id, :to_account_id, :user, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0.01}
  validate  :check_needed_funds_on_account
  validate  :validate_default_currency_account

  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  scope :in_date, -> (date) { where(created_at: date..date.end_of_month)}
  scope :from_account, -> (from_account_id) { where(from_account_id: from_account_id) }
  scope :to_account, -> (to_account_id) { where(to_account_id: to_account_id) }

  before_create   :set_amount_in_default_currency

  after_create  :change_accounts_after_create
  after_destroy :affect_to_accounts_after_deletion

  def change_accounts_after_create
    ActiveRecord::Base.transaction do
        from_account.minus(amount)
        if from_account.currency == Currency.default_currency
          to_account.plus(amount/to_account.currency.exchange_rate)
        else
          to_account.plus(amount*from_account.currency.exchange_rate)
        end
    end
  end

  def affect_to_accounts_after_deletion
    ActiveRecord::Base.transaction do
      from_account.plus(amount)
      if to_account.currency == Currency.default_currency
        to_account.minus(amount_in_dc)
      else
        to_account.minus(amount/to_account.currency.exchange_rate)
      end
    end
  end

  private
  def check_needed_funds_on_account
    return if from_account.nil? || amount.nil?
    errors.add(:from_account, I18n::t('account.doesnt_enough_money')) if (from_account.funds - amount) < 0
  end

  def set_amount_in_default_currency
    self.amount_in_dc = amount * from_account.currency.exchange_rate
  end

  def validate_default_currency_account
    if from_account.present? && to_account.present?
      if from_account.currency != Currency.default_currency && to_account.currency != Currency.default_currency
        errors.add(:account, I18n::t('account.currency_should_be_default'))
      end
    end
  end
end
