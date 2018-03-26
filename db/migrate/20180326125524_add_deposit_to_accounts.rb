class AddDepositToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :deposit, :boolean, default: false
  end
end
