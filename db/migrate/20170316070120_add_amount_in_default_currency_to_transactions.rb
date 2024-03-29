class AddAmountInDefaultCurrencyToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :amount_in_dc, :decimal, { precision: 10, scale: 2, default: 0.00 }
  end
end
