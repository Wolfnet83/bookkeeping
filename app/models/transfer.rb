class Transfer < ActiveRecord::Base
  validates :from_account_id, :to_account_id, presence: true
  validate  :check_needed_funds_on_account

  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  after_create  :change_accounts_after_create
  after_destroy :affect_to_accounts_after_deletion

  def change_accounts_after_create
    ActiveRecord::Base.transaction do
      from_account.minus(amount)
      to_account.plus(amount)
    end
  end

  def affect_to_accounts_after_deletion
    ActiveRecord::Base.transaction do
      from_account.plus(amount)
      to_account.minus(amount)
    end
  end

  private
  def check_needed_funds_on_account
    errors.add(:from_account, I18n::t('account.doesnt_enough_money')) if (from_account.funds - amount) < 0
  end
end
