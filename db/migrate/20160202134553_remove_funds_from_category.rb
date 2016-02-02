class RemoveFundsFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :funds
  end
end
