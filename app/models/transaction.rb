class Transaction < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  belongs_to :user

  validates :account_id, :category_id, :user_id, presence: true
  validates :amount, presence: true, numericality: true

  after_create :affect_to_accounts_after_creation
  after_destroy :affect_to_accounts_after_deletion

  def affect_to_accounts_after_creation
    account.minus(amount)
  end

  def affect_to_accounts_after_deletion
    account.plus(amount)
  end
end
