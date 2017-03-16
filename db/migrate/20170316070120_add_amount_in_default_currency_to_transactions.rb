class AddAmountInDefaultCurrencyToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :amount_in_dc, :decimal, { precision: 10, scale: 2, default: 0.00 }
  end
end
