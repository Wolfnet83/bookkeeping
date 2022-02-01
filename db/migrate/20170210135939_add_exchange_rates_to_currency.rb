class AddExchangeRatesToCurrency < ActiveRecord::Migration[5.2]
  def change
    add_column :currencies, :exchange_rate, :float
  end
end
