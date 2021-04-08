require "rails_helper"
RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end
  describe "relationships" do
    it { should have_many :items}
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "class methods" do
    it "can find top mercahnts by revenue" do
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
      item_6 = create(:item,name: "item_6", merchant_id: mer_1.id)
      item_7 = create(:item,name: "item_7", merchant_id: mer_2.id)
      item_8 = create(:item,name: "item_8", merchant_id: mer_2.id)
      item_9 = create(:item,name: "item_9", merchant_id: mer_2.id)
      invoice1 = create(:invoice, customer_id: cust_1.id)
      invoice2 = create(:invoice, customer_id: cust_2.id)
      invoice3 = create(:invoice, customer_id: cust_3.id)
      invoice4 = create(:invoice, customer_id: cust_4.id)
      invoice5 = create(:invoice, customer_id: cust_5.id)
      invoice6 = create(:invoice, customer_id: cust_6.id)
      invoice7 = create(:invoice, customer_id: cust_7.id)
      invoice8 = create(:invoice, customer_id: cust_8.id)
      invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
      invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
      invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
      invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
      invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
      invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id, quantity: 10, unit_price:10)
      invoice_item7 = create(:invoice_item, item_id:item_7.id, invoice_id:invoice7.id, quantity: 1, unit_price:1)
      invoice_item8 = create(:invoice_item, item_id:item_8.id, invoice_id:invoice8.id, quantity: 1, unit_price: 1)
      transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
      transaction2 = create(:transaction, result: "success", invoice_id: invoice7.id)
      transaction2 = create(:transaction, result: "success", invoice_id: invoice3.id)
      transaction3 = create(:transaction, result: "success", invoice_id: invoice8.id)
      transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id)
      transaction5 = create(:transaction, result: "success", invoice_id: invoice5.id)
      transaction8 = create(:transaction, result: "success", invoice_id: invoice6.id)
      transaction8 = create(:transaction, result: "success", invoice_id: invoice2.id)

      expect(Merchant.find_top_merchants(2)).to eq([mer_1, mer_2])
    end

    it "can find by revenue when passed an id" do
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
      item_6 = create(:item,name: "item_6", merchant_id: mer_1.id)
      item_7 = create(:item,name: "item_7", merchant_id: mer_2.id)
      item_8 = create(:item,name: "item_8", merchant_id: mer_2.id)
      item_9 = create(:item,name: "item_9", merchant_id: mer_2.id)
      item_10 = create(:item,name: "item_9", merchant_id: mer_3.id)
      invoice1 = create(:invoice, customer_id: cust_1.id)
      invoice2 = create(:invoice, customer_id: cust_2.id)
      invoice3 = create(:invoice, customer_id: cust_3.id)
      invoice4 = create(:invoice, customer_id: cust_4.id)
      invoice5 = create(:invoice, customer_id: cust_5.id)
      invoice6 = create(:invoice, customer_id: cust_6.id)
      invoice7 = create(:invoice, customer_id: cust_7.id)
      invoice8 = create(:invoice, customer_id: cust_8.id)
      invoice9 = create(:invoice, customer_id: cust_8.id)
      invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
      invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
      invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
      invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
      invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
      invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id, quantity: 10, unit_price:10)
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
      rev = Merchant.find_revenue(mer_1.id).first
      rev2 = Merchant.find_revenue(mer_2.id).first
      rev3 = Merchant.find_revenue(mer_3.id).first
      expect(rev.revenue).to eq(193)
      expect(rev2.revenue).to eq(11)
      expect(rev3.revenue).to eq(0)
    end

    it "returns most items sold by each merchant " do
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
      item_6 = create(:item,name: "item_6", merchant_id: mer_1.id)
      item_7 = create(:item,name: "item_7", merchant_id: mer_2.id)
      item_8 = create(:item,name: "item_8", merchant_id: mer_2.id)
      item_9 = create(:item,name: "item_9", merchant_id: mer_2.id)
      item_10 = create(:item,name: "item_9", merchant_id: mer_3.id)
      invoice1 = create(:invoice, customer_id: cust_1.id)
      invoice2 = create(:invoice, customer_id: cust_2.id)
      invoice3 = create(:invoice, customer_id: cust_3.id)
      invoice4 = create(:invoice, customer_id: cust_4.id)
      invoice5 = create(:invoice, customer_id: cust_5.id)
      invoice6 = create(:invoice, customer_id: cust_6.id)
      invoice7 = create(:invoice, customer_id: cust_7.id)
      invoice8 = create(:invoice, customer_id: cust_8.id)
      invoice9 = create(:invoice, customer_id: cust_8.id)
      invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
      invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
      invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
      invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
      invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
      invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id, quantity: 10, unit_price:10)
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
      most_items = Merchant.most_items_sold(2).first
      second_most = Merchant.most_items_sold(2).last
      last = Merchant.most_items_sold(3).last
      expect(most_items.count).to eq(37)
      expect(second_most.count).to eq(11)
      expect(last.count).to eq(1)
    end
  end

  describe "application record methods " do
    it "returns proper number of merchants" do
      create_list(:merchant, 100)
      expect(Merchant.collect_records(2, 1).count).to eq(2)
      expect(Merchant.collect_records(40, 2).count).to eq(40)
      expect(Merchant.collect_records(102, 1).count).to eq(100)

    end

    it "returns proper records when given id" do
      merchant = create(:merchant)
      create_list(:merchant, 50)
      expect(Merchant.find_record(merchant.id)).to eq(merchant)
    end

    it "can find by name fragments" do
      merchant1 = create(:merchant, name: "Turing")
      merchant2 = create(:merchant, name: "Ring World")
      merchants = create_list(:merchant, 50)
      expect(Merchant.find_by_fragment("ring")).to eq([merchant1, merchant2])
    end
  end
end
