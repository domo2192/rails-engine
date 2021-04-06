class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_one :merchant, through: :item


  enum status: ["cancelled", "in progress", "completed"]

  def self.find_unshipped_revenue(quantity = 10)
    self.joins(:invoice_items).joins(:transactions)
    .select("invoices.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS potential_revenue").
    group(:id).
    where(invoices: {status: "packaged"}).
    order("potential_revenue DESC").
    limit(quantity)
  end
end
