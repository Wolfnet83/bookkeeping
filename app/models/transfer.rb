class Transfer < ActiveRecord::Base
  validates :from_account_id, :to_account_id, presence: true

  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  after_create :change_accounts_after_create

  def change_accounts_after_create
    from_account.minus(amount)
    to_account.plus(amount)
  end
end
