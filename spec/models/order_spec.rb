require 'rails_helper'

RSpec.describe Order, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:order)).to be_valid
  end

  it "is invalid without a name" do
    order = FactoryBot.build(:order, customer_name: nil)
    order.valid?
    expect(order.errors[:customer_name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    order = FactoryBot.build(:order, customer_email: nil)
    order.valid?
    expect(order.errors[:customer_email]).to include("can't be blank")
  end

  it "is invalid total_price is less than 0.01" do
    order = FactoryBot.build(:order, total_price: 0.001)
    order.valid?
    expect(order.errors[:total_price]).to include("must be greater than or equal to 0.01")
  end

  it "should handle filters orders by email well" do
    order1 = FactoryBot.create(:order, customer_email: 'alviand03@gmail.com')
    order2 = FactoryBot.create(:order, customer_email: 'asd@gmail.com')
    order3 = FactoryBot.create(:order, customer_email: 'alviand03@gmail.com')

    expect(Order.filter_by_email('alviand03@gmail.com')).to match_array([order1, order3])
  end

  it "should handle filters orders by minimum total price well" do
    order1 = FactoryBot.create(:order, total_price: 100)
    order2 = FactoryBot.create(:order, total_price: 200)
    order3 = FactoryBot.create(:order, total_price: 300)

    expect(Order.filter_by_min_total_price(200)).to match_array([order2, order3])
  end

  it "should handle filters orders by maximum total price well" do
    order1 = FactoryBot.create(:order, total_price: 100)
    order2 = FactoryBot.create(:order, total_price: 200)
    order3 = FactoryBot.create(:order, total_price: 300)

    expect(Order.filter_by_max_total_price(200)).to match_array([order1, order2])
  end

  it "should handle filters orders by start date well" do
    order1 = FactoryBot.create(:order, created_at: Date.today)
    order2 = FactoryBot.create(:order, created_at: Date.today - 1)
    order3 = FactoryBot.create(:order, created_at: Date.today - 2)

    expect(Order.filter_by_start_date(order2.created_at)).to match_array([order1, order2])
  end

  it "should handle filters orders by end date well" do
    order1 = FactoryBot.create(:order, created_at: Date.today)
    order2 = FactoryBot.create(:order, created_at: Date.today - 1)
    order3 = FactoryBot.create(:order, created_at: Date.today - 2)

    expect(Order.filter_by_end_date(order2.created_at)).to match_array([order2, order3])
  end

end
