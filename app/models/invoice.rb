class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discount
    invoice_items
      .joins(item: {merchant: :discounts})
      .where("invoice_items.quantity >= discounts.threshold")
      .select("invoice_items.*, max(discounts.percent_discount / 100.0 * invoice_items.unit_price * quantity) as calculated_discount")
      .group("invoice_items.id")
      .sum {|ii| ii.calculated_discount}
  end
  
  def discounted_revenue
    total_revenue - total_discount
  end
end
