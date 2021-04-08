require "rails_helper"

describe Invoice do
  describe "relationships" do
  it { should belong_to :customer }
  it { should have_many :invoice_items }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many :transactions }
  end

  it "can find unshipped revenue" do
    mer_1 = create(:merchant)
    mer_2 = create(:merchant)
    mer_3 = create(:merchant)
    mer_4 = create(:merchant)
    cust_1 = create(:customer)
    cust_2 = create(:customer)
    cust_3 = create(:customer)
    cust_4 = create(:customer)
    cust_5 = create(:customer)
    cust_6 = create(:customer)
    cust_7 = create(:customer)
    cust_8 = create(:customer)
    cust_9 = create(:customer)
    cust_10 = create(:customer)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    item_2 = create(:item, name: "item_2", merchant_id: mer_1.id)
    item_3 = create(:item, name: "item_3", merchant_id: mer_1.id)
    item_4 = create(:item, name:"item_4", merchant_id: mer_1.id)
    item_5 = create(:item,name: "item_5", merchant_id: mer_1.id)
    item_6 = create(:item,name: "item_6", merchant_id: mer_3.id)
    item_7 = create(:item,name: "item_7", merchant_id: mer_2.id)
    item_8 = create(:item,name: "item_8", merchant_id: mer_2.id)
    item_9 = create(:item,name: "item_9", merchant_id: mer_2.id)
    item_10 = create(:item,name: "item_9", merchant_id: mer_3.id)
    invoice1 = create(:invoice, customer_id: cust_1.id, status: "packaged")
    invoice2 = create(:invoice, customer_id: cust_2.id, status: "packaged")
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_5.id)
    invoice6 = create(:invoice, customer_id: cust_6.id, status: "packaged")
    invoice7 = create(:invoice, customer_id: cust_7.id)
    invoice8 = create(:invoice, customer_id: cust_8.id)
    invoice9 = create(:invoice, customer_id: cust_8.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2) # 16
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5) # 50
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
    invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id, quantity: 10, unit_price:10) # 100
    invoice_item7 = create(:invoice_item, item_id:item_7.id, invoice_id:invoice7.id, quantity: 10, unit_price:1)
    invoice_item8 = create(:invoice_item, item_id:item_8.id, invoice_id:invoice8.id, quantity: 1, unit_price: 1)
    invoice_item8 = create(:invoice_item, item_id:item_10.id, invoice_id:invoice9.id, quantity: 1, unit_price: 0)
    transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
    transaction2 = create(:transaction, result: "success", invoice_id: invoice7.id)
    transaction2 = create(:transaction, result: "success", invoice_id: invoice3.id)
    transaction3 = create(:transaction, result: "success", invoice_id: invoice8.id)
    transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id)
    transaction5 = create(:transaction, result: "success", invoice_id: invoice5.id)
    transaction8 = create(:transaction, result: "success", invoice_id: invoice6.id)
    transaction8 = create(:transaction, result: "success", invoice_id: invoice2.id)
    transaction8 = create(:transaction, result: "success", invoice_id: invoice9.id)
    missing_rev = Invoice.find_unshipped_revenue(3).first
    expect(missing_rev.potential_revenue).to eq(100)
    expect(missing_rev.id).to eq(invoice6.id)
  end

  
end
