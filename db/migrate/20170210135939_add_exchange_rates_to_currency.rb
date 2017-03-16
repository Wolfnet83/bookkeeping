class AddExchangeRatesToCurrency < ActiveRecord::Migration[5.0]
  def change
    add_column :currencies, :exchange_rate, :float
  end
end
