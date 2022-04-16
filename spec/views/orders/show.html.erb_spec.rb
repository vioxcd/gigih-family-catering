require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      total_price: 2.5,
      customer_name: "Customer Name",
      customer_email: "Customer Email",
      status: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Customer Name/)
    expect(rendered).to match(/Customer Email/)
    expect(rendered).to match(/3/)
  end
end
