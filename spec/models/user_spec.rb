require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it { should have_many(:accounts) }
  it { should have_many(:categories) }
  it { should have_many(:transactions) }
  it { should have_many(:transfers) }
end
