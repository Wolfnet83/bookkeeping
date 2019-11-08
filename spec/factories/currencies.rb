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

FactoryBot.define do
  factory :currency do
    name { "Dollar US" }
    abbr_name { "USD" }
    exchange_rate { "19.91" }

    factory :default_currency do
      name { "Moldavian Lei" }
      abbr_name { "MDL" }
      exchange_rate { "1.0" }
      default_currency { true }
    end
  end
end
