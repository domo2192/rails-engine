require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  it "can find any delete items and delete the invoice if its the only item associated" do
    merchant = create(:merchant)
    item1 = Item.create!({name: "doomed_item", description: "doesn't matter", unit_price: 10, merchant_id: merchant.id})
    create_list(:item, 15)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    invoice4 = create(:invoice)
    invoice5 = create(:invoice)
    create_list(:invoice, 10)
    invoice_item = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: Item.last.id, invoice_id: invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: Item.second_to_last.id, invoice_id: invoice5.id)
    expect(Invoice.all.first).to eq(invoice1)
    item1.find_single_invoices
    expect{Invoice.find(invoice1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{Invoice.find(invoice2.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{InvoiceItem.find(invoice_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect{InvoiceItem.find(invoice_item2.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(Invoice.all.first).to eq(invoice3)
  end

  describe "application record methods" do
    it "finds items by max price" do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1)
      create_list(:item, 15, merchant: merchant1, unit_price: 49)
      expect(Item.find_by_max_price(50).count).to eq(45)
      expect(Item.find_by_max_price(49).count).to eq(45)
      expect(Item.find_by_max_price(48.99).count).to eq(30)
    end

    it "can find items by min price" do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1)
      create_list(:item, 15, merchant: merchant1, unit_price: 49)
      expect(Item.find_by_min_price(50).count).to eq(15)
      expect(Item.find_by_min_price(11).count).to eq(45)
      expect(Item.find_by_min_price(10).count).to eq(60)
    end

    it "finds by price range for items" do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1)
      create_list(:item, 15, merchant: merchant1, unit_price: 49)
      expect(Item.find_by_range_price(40, 30).count).to eq(15)
      expect(Item.find_by_range_price(50, 30).count).to eq(30)
      expect(Item.find_by_range_price(100, 45).count).to eq(30)
    end
  end
end
