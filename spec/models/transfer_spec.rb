# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  from_account_id :integer
#  to_account_id   :integer
#  amount          :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  amount_in_dc    :decimal(10, 2)   default(0.0)
#

require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it "has a valid factory" do
    expect(create(:transfer)).to be_valid
  end

  describe '.validation' do
    context 'valid' do
      subject { create(:transfer) }
      it { should validate_presence_of(:from_account_id) }
      it { should validate_presence_of(:to_account_id) }
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:amount) }
      it { should validate_numericality_of(:amount) }
    end
  end
end
