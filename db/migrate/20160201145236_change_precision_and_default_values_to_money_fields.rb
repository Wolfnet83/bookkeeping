class ChangePrecisionAndDefaultValuesToMoneyFields < ActiveRecord::Migration
  def change
    change_column :accounts, :funds, :decimal, { precision: 10, scale: 2, default: 0.00 }
    change_column :transactions, :amount, :decimal, { precision:10, scale: 2, default: 0.00 }
  end
end
