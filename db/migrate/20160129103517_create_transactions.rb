class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|

      t.integer :user_id
      t.integer :account_id
      t.integer :category_id
      t.float   :amount
      t.text    :comment
      t.timestamps null: false
    end
  end
end
