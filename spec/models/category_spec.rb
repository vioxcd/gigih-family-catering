require 'rails_helper'

RSpec.describe Category, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it "is invalid without name" do
    category = FactoryBot.build(:category, name: nil)
    
    expect(category).to be_invalid
  end

  it "is invalid with duplicate name" do
    category1 = FactoryBot.create(:category, name: "Main Dish")
    category2 = FactoryBot.build(:category, name: "Main Dish")

    category2.valid? 
    
    expect(category2.errors[:name]).to include("has already been taken")
  end
  
end
