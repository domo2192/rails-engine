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
    merge(Invoice.shipped).
    order("revenue DESC").
    limit(quantity)
  end

  def self.most_items_sold(quantity)
    self.
    select("merchants.*, SUM(invoice_items.quantity) AS count").
    joins(items: {invoice_items: :transactions}).
    merge(Transaction.successful).
    merge(Invoice.shipped).
    group(:id).
    order("count DESC").
    limit(quantity)
  end

  def self.find_revenue(id)
    select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue").
    joins(invoice_items: :transactions).
    group(:id).
    merge(Transaction.successful).
    merge(Invoice.shipped).
    where("merchants.id = #{id}")
  end

  # def self.revenue_between(starttime, endtime)
  #   joins(invoice_items: :transactions).
  #   select("transactions.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue").
  #   merge(Transaction.successful).
  #   group('transactions.created_at < ? AND transactions.created_at > ?', starttime, endtime)
  # end
end
