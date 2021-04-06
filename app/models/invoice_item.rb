class InvoiceItem < ApplicationRecord
 belongs_to :invoice
 belongs_to :item
 has_many :transactions, through: :invoice
 has_one :merchant, through: :item
 has_one :customer, through: :invoice
 validates_presence_of :unit_price, :quantity

 enum status: [:pending, :packaged, :shipped]

end
