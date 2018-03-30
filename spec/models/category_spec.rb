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

require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a valid factory" do
    expect(create(:category)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should have_many(:transactions) }
end
