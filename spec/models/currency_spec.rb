# == Schema Information
#
# Table name: currencies
#
#  id               :integer          not null, primary key
#  name             :string
#  abbr_name        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  exchange_rate    :float
#  default_currency :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Currency, type: :model do
  it "has a valid factory" do
    expect(create(:currency)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:abbr_name) }
  it { should have_many(:accounts) }
end
