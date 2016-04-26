class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :abbr_name

      t.timestamps null: false
    end
  end
end
