# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  category_type     :integer
#  category_group_id :integer
#

class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :transactions, dependent: :destroy
  belongs_to :category_group

  scope :ordered,-> { order(:name) }

  def income?
    category_type == INCOME.to_i
  end
end
