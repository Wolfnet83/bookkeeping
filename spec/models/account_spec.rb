# == Schema Information
#
# Table name: accounts
#
#  id          :integer          not null, primary key
#  name        :string
#  funds       :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  currency_id :integer
#  funds_in_dc :decimal(10, 2)   default(0.0)
#  active      :boolean          default(TRUE)
#  deposit     :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Account, type: :model do

  it "has a valid factory" do
    expect(create(:account)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:funds) }
  it { should validate_numericality_of(:funds).is_greater_than_or_equal_to(0) }
  it { should have_many(:transactions) }

  describe "test account methods" do
    before(:each) do
      @account = create(:account)
    end

    it "has 0 funds by default" do
      expect(@account.funds).to eq(0)
    end

    it "increase amount by 50" do
      @account.plus(50)
      expect(@account.funds).to eq(50)
    end

    it "decrease amount by 5" do
      @account.plus(50)
      @account.minus(5)
      expect(@account.funds).to eq(45)
    end
  end
end
