class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :merchant
  has_many :invoice_items dependant: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices 
end
