# == Schema Information
#
# Table name: transactions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  account_id   :integer
#  category_id  :integer
#  amount       :decimal(10, 2)   default(0.0)
#  comment      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  amount_in_dc :decimal(10, 2)   default(0.0)
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do

  it "has a valid factory" do
    expect(create(:transaction)).to be_valid
  end

  describe '.validation' do
    context 'valid' do
      subject { create(:transaction) }
      it { should validate_presence_of(:account_id) }
      it { should validate_presence_of(:category_id) }
      it { should validate_presence_of(:user_id) }
      it { should validate_presence_of(:amount) }
      it { should validate_numericality_of(:amount) }
    end
  end

end
