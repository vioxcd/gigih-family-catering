class MenuItem < ApplicationRecord
  has_many :menu_categories
  has_many :categories, through: :menu_categories
  accepts_nested_attributes_for :menu_categories, reject_if: :all_blank, allow_destroy: true

  has_many :order_details

  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 150 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  
  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end

  def has_category
    add_error_at_least_one_category if self.categories.blank?
  end

  def add_error_at_least_one_category
    errors.add(:base, 'Must add at least one category')
  end
  
end
