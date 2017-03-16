class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  belongs_to :user

  validates :account_id, :category_id, :user_id, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0.01}
  validate  :check_needed_funds_on_account

  before_create :set_amount_in_default_currency
  after_create  :affect_to_accounts_after_creation
  after_destroy :affect_to_accounts_after_deletion
  after_update  :affect_to_accounts_after_update
  after_save    :calculate_accounts_in_default_currency

  scope :in_current_month, -> { where(created_at: Date.today.beginning_of_month..Date.today.end_of_month)}
  scope :in_date, -> (date) { where(created_at: date..date.end_of_month)}
  scope :account, -> (account_id) { where(account_id: account_id) }
  scope :category, -> (category_id) { where(category_id: category_id) }
  scope :in_year, -> (year) {where(created_at: year..year.end_of_year)}

  def affect_to_accounts_after_creation
    category.income? ? account.plus(amount) : account.minus(amount)
  end

  def affect_to_accounts_after_deletion
    category.income? ? account.minus(amount) : account.plus(amount)
  end

  def affect_to_accounts_after_update
    if account_id_was != account_id
      account_was = Account.find_by_id(account_id_was)
    else
      account_was = account
    end
    if category.income?
      account_was.minus(amount_was)
      account.plus(amount)
    else
      account_was.plus(amount_was)
      account.minus(amount)
    end
  end

  private
  def check_needed_funds_on_account
    return if category.nil? || amount.nil? || account.nil?
    unless category.income?
      errors.add(:account, I18n::t('account.doesnt_enough_money')) if (account.funds - amount) < 0
    end
  end

  def calculate_accounts_in_default_currency
    Account.calculate_default_currencies
  end

  def set_amount_in_default_currency
    self.amount_in_dc = amount * account.currency.exchange_rate
  end
end
