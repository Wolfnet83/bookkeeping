class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.float :funds
      t.timestamps null: false
    end
  end
end
