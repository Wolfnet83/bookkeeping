class AddCategoryTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_type, :integer
  end
end
