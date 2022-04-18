class Order < ApplicationRecord
  has_many :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true

  enum status: { NEW: 0, PAID: 1, CANCELED: 2 }
  
  validates :customer_name, presence: true, length: { maximum: 200 }
  validates :customer_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid email format' }
  validates :total_price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :status, inclusion: { in: statuses.keys }

  after_initialize :set_defaults, unless: :persisted?

  def delete_associate_order_details
    self.order_details.destroy_all
  end

  def set_defaults
    self.order_date ||= DateTime.now
    self.status ||= :NEW
  end

  scope :filter_by_email, ->(customer_email) { customer_email.present? ? where(customer_email: customer_email) : all }
  scope :filter_by_min_total_price, ->(min_total_price) { min_total_price.present? ? where('total_price >= ?', min_total_price.to_f) : all }
  scope :filter_by_max_total_price, ->(max_total_price) { max_total_price.present? ? where('total_price <= ?', max_total_price.to_f) : all }

  scope :filter_by_start_date, ->(start_date) do
    if start_date.present?
      begin
        where('created_at >= ?', start_date.to_time(:utc))
      rescue ArgumentError
        all
      end
    else
      all
    end
  end

  scope :filter_by_end_date, ->(end_date) do
    if end_date.present?
      begin
        where('created_at <= ?', end_date.to_time(:utc) + 1.days - 1.minutes)
      rescue ArgumentError
        all
      end
    else
      all
    end
  end
end
