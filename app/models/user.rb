class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  has_many :accounts
  has_many :categories
  has_many :transactions
  has_many :transfers
  has_many :planned_fees
  has_many :planned_fee_templates
end
