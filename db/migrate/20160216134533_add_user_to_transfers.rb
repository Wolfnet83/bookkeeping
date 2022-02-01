class AddUserToTransfers < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :user_id, :integer
  end
end
