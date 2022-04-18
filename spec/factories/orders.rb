FactoryBot.define do
  factory :order do
    total_price { 10000 }
    customer_name { "M Alviand F" }
    customer_email { Faker::Internet.email }
    status { :NEW }
  end
end
