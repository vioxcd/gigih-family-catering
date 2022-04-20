class Order < ApplicationRecord
  has_many :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true

  enum status: { NEW: 0, PAID: 1, CANCELED: 2 }
  
  validates :customer_name, presence: true
  validates :customer_email,  presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'invalid email format' }
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :status, inclusion: { in: statuses.keys }

  after_initialize :set_defaults, unless: :persisted?

  scope :filter_by_email, ->(customer_email) { customer_email.present? ? where(customer_email: customer_email) : all }
  scope :filter_by_min_total_price, ->(min_total_price) { min_total_price.present? ? where('total_price >= ?', min_total_price.to_f) : all }
  scope :filter_by_max_total_price, ->(max_total_price) { max_total_price.present? ? where('total_price <= ?', max_total_price.to_f) : all }
  scope :filter_by_start_date, ->(start_date) { start_date.present? ? where('created_at >= ?', start_date) : all }
  scope :filter_by_end_date, ->(end_date) { end_date.present? ? where('created_at <= ?', end_date) : all }

  def delete_associate_order_details
    self.order_details.destroy_all
  end

  def set_defaults
    self.order_date ||= DateTime.now
    self.status ||= :NEW
  end
end
