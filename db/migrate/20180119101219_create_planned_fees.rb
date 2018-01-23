class CreatePlannedFees < ActiveRecord::Migration[5.0]
  def change
    create_table :planned_fees do |t|
      t.string :name
      t.string :amount
      t.boolean :paid, default: false
      t.references :user

      t.timestamps
    end
  end
end
