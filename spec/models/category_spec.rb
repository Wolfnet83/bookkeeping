require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a valid factory" do
    expect(create(:category)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should have_many(:transactions) }
end
