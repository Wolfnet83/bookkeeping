class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :transactions, dependent: :destroy
  belongs_to :category_group

  def income?
    category_type == INCOME.to_i
  end
end
