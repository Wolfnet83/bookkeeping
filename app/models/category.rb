class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :transactions, dependent: :destroy

  def income?
    category_type == INCOME.to_i
  end
end
