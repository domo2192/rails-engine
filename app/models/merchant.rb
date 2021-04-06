class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  def self.find_top_merchants(quantity)
    self.
    select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue").
    joins(invoice_items: :transactions).
    group(:id).
    merge(Transaction.successful).
    order("revenue DESC").
    limit(quantity)
  end

end
