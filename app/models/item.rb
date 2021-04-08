class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def find_single_invoices
    x = invoices.joins(:items).
    select("invoices.*, count(items.*)").
    group("invoices.id").
    having("count(items.*)=1").pluck(:id)
    InvoiceItem.where(item_id: self.id).delete_all
    Invoice.delete(x)
  end

  def self.find_top_items(quantity)
    quantity = 10 unless quantity
      joins(:transactions).
      merge(Transaction.successful).
      merge(Invoice.shipped).
      group(:id).
      select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue").
      order("revenue DESC").
      limit(quantity)
  end
end
