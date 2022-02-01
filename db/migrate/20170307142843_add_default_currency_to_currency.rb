class AddDefaultCurrencyToCurrency < ActiveRecord::Migration[5.2]
  def change
    add_column :currencies, :default_currency, :boolean, default: false
  end
end
