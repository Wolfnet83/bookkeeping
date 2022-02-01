class RemoveFundsFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :funds
  end
end
