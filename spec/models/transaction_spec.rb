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
