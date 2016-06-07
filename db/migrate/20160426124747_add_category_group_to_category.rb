class AddCategoryGroupToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :category_group_id, :integer
  end
end
