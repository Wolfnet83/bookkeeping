# == Schema Information
#
# Table name: category_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CategoryGroup, type: :model do
  it "has a valid factory" do
    expect(create(:category_group)).to be_valid
  end

  it { should validate_presence_of(:name) }
end
