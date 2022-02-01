class CreatePlannedFees < ActiveRecord::Migration[5.2]
  def change
    create_table :planned_fees do |t|
      t.string      :name
      t.decimal     :amount, precision: 10, scale: 2, default: 0.00
      t.integer     :status, default: 0, limit: 2
      t.references  :currency
      t.references  :user

      t.timestamps
    end
  end
end
