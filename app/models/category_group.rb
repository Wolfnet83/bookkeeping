class CategoryGroup < ActiveRecord::Base
  has_many :categories
  after_destroy :reset_categories
  validates_presence_of :name

  def set_default_category
    categories = Category.all
    categories.each do |category|
      category.update_attribute(:category_group_id, self.id) if category.category_group_id.nil?
    end
  end

  def ordered_categories
    self.categories.ordered
  end

  private
  def reset_categories
    self.categories.each do |category|
      category.update_attribute(:category_group_id, nil)
    end
  end
end
