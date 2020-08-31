FactoryBot.define do
  factory :item do
    name {Faker::Beer.name }
    description {Faker::Food.description }
    unit_price {Faker::Commerce.price }
  end
end
