FactoryBot.define do
  factory :order do
    order_date { "2022-04-16 13:44:16" }
    total_price { 1.5 }
    customer_name { "MyString" }
    customer_email { "MyString" }
    status { 1 }
  end
end
