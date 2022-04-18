class Order < ApplicationRecord
  has_many :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true

  validates :customer_name, presence: true, length: { maximum: 200 }
  validates :customer_email, format: { with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z/, message: 'invalid email format' }
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  
  enum status: { NEW: 0, PAID: 1, CANCELED: 2 }

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.order_date ||= DateTime.now
    self.status ||= :NEW
  end
end
