FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    description { "Lorem Ipsum Dolor sit amet" }
    price { 10000.0 }
  end
end
