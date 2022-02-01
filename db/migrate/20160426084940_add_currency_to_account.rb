class AddCurrencyToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :currency_id, :integer
  end
end
