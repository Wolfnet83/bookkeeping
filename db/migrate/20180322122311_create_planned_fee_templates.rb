class CreatePlannedFeeTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :planned_fee_templates do |t|
      t.string      :name
      t.decimal     :amount, precision: 10, scale: 2, default: 0.00
      t.boolean     :active, default: true
      t.references  :currency
      t.references  :user

      t.timestamps
    end
  end
end
