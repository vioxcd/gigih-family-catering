require 'rails_helper'

RSpec.describe "menu_items/show", type: :view do
  before(:each) do
    @menu_item = assign(:menu_item, MenuItem.create!(
      name: "Name",
      price: 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
  end
end
