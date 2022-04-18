FactoryBot.define do
  factory :order_detail do
    order_id { 1 }
    menu_item_id { 1 }
    price { 1.5 }
    quantity { 1 }
  end
end
