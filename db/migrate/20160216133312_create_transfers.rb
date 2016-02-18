class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :from_account_id
      t.integer :to_account_id
      t.float   :amount
      t.timestamps null: false
    end
  end
end
