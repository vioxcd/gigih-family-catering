require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:menu_item)).to be_valid
  end

  it 'is valid with a name and a description' do
    expect(FactoryBot.build(:menu_item)).to be_valid
  end

  it 'is invalid without a name' do
    menu_item = FactoryBot.build(:menu_item, name: nil)
    menu_item.valid?
    expect(menu_item.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    menu_item1 = FactoryBot.create(:menu_item, name: 'Nasi Uduk')
    menu_item2 = FactoryBot.build(:menu_item, name: 'Nasi Uduk')

    menu_item2.valid?

    expect(menu_item2.errors[:name]).to include("has already been taken")
  end

  describe 'self#by_letter' do
    context 'with matching letter' do
      it "should return a sorted array of results that match" do
        menu_item1 = FactoryBot.create(:menu_item, name: 'Nasi Uduk')
        menu_item2 = FactoryBot.create(:menu_item, name: 'Kerak Telor')
        menu_item3 = FactoryBot.create(:menu_item, name: 'Nasi Semur Jengkol')
  
        expect(MenuItem.by_letter("N")).to eq([menu_item3, menu_item1])
      end
    end
  end
end
