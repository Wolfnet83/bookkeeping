class Currency < ActiveRecord::Base
  validates :name, :abbr_name, presence: true

  has_many :accounts
end
