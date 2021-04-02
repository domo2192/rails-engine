class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependant: :destroy
  has_many :invoice_items, dependant: :destroy
  has_many :items, through: :invoice_items
  has_one :merchant, through: :item


  enum status: ["cancelled", "in progress", "completed"]
end
