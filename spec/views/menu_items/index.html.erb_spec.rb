require 'rails_helper'

RSpec.describe "menu_items/index", type: :view do
  before(:each) do
    assign(:menu_items, [
      MenuItem.create!(
        name: "Name1",
        price: 2.5
      ),
      MenuItem.create!(
        name: "Name2",
        price: 2.5
      )
    ])
  end

  it "renders a list of menu_items" do
    render
    assert_select "tr>td", text: 2.5.to_s, count: 2
  end
end
