class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :transactions, dependent: :destroy
  belongs_to :category_group

  scope :ordered,-> { order(:name) }

  def income?
    category_type == INCOME.to_i
  end
end
