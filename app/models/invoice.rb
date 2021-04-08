class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_one :merchant, through: :item
  scope :shipped, -> {where(status: "shipped")}


  def self.find_unshipped_revenue(quantity = 10)
    self.joins(:invoice_items).joins(:transactions)
    .select("invoices.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS potential_revenue").
    group(:id).
    where(invoices: {status: "packaged"}).
    order("potential_revenue DESC").
    limit(quantity)
  end
end
