class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  belongs_to :user

  validates :account_id, :category_id, :user_id, presence: true
  validates :amount, presence: true, numericality: true

  after_create :affect_to_accounts_after_creation
  after_destroy :affect_to_accounts_after_deletion

  scope :in_current_month, -> { where(created_at: Date.today.beginning_of_month..Date.today.end_of_month)}
  scope :in_date, -> (date) { where(created_at: date..date.end_of_month)}
  scope :account, -> (account_id) { where(account_id: account_id) }
  scope :category, -> (category_id) { where(category_id: category_id) }

  def affect_to_accounts_after_creation
    category.income? ? account.plus(amount) : account.minus(amount)
  end

  def affect_to_accounts_after_deletion
    category.income? ? account.minus(amount) : account.plus(amount)
  end
end
