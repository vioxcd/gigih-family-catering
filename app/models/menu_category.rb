class MenuCategory < ApplicationRecord
  belongs_to :category
  belongs_to :menu_item
end
