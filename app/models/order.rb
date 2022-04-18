class Order < ApplicationRecord
  has_many :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
  
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.order_date  ||= DateTime.now
  end
end
