class Transfer < ActiveRecord::Base
  validates :from_account_id, :to_account_id, presence: true
  validate  :check_needed_funds_on_account

  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  after_create :change_accounts_after_create

  def change_accounts_after_create
    from_account.minus(amount)
    to_account.plus(amount)
  end

  private
  def check_needed_funds_on_account
    errors.add(:from_account, I18n::t('account.doesnt_enough_money')) if (from_account.funds - amount) < 0
  end
end
