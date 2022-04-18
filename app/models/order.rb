class Order < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.order_date  ||= DateTime.now
  end
end
