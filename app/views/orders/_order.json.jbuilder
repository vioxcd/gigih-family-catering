json.extract! order, :id, :order_date, :total_price, :customer_name, :customer_email, :status, :created_at, :updated_at
json.url order_url(order, format: :json)
