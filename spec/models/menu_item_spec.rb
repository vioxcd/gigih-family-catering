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

  it "is invalid with a description over 150 characters" do
    menu_item = FactoryBot.build(:menu_item, description: 'a' * 151)
    menu_item.valid?
    expect(menu_item.errors[:description]).to include("is too long (maximum is 150 characters)")
  end

  it "is invalid without a price" do
    menu_item = FactoryBot.build(:menu_item, price: nil)
    menu_item.valid?
    expect(menu_item.errors[:price]).to include("can't be blank")
  end

  it "is invalid with a price less than 0.01" do
    menu_item = FactoryBot.build(:menu_item, price: 0.001)
    menu_item.valid?
    expect(menu_item.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it "is invalid without category" do
    menu_item = FactoryBot.build(:menu_item)
    
    menu_item.has_category
    expect(menu_item.errors[:category]).to include("must add at least one category")
  end

  it "is valid if has more than one category" do
    menu_item = FactoryBot.build(:menu_item)
    menu_item.categories << FactoryBot.create(:category)
    menu_item.categories << FactoryBot.create(:category, name: 'Dessert')

    menu_item.has_category
    expect(menu_item).to be_valid
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
