class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.float :funds
      t.timestamps null: false
    end
  end
end
