require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe 'delete /api/v1/items/id' do
    it 'deletes an item' do
      merchant = create(:merchant)
      item1 = Item.create!({name: "doomed_item", description: "doesn't matter", unit_price: 10, merchant_id: merchant.id})
      create_list(:item, 15)
      expect(Item.count).to eq(16)
      delete "/api/v1/items/#{item1.id}"
      expect(response).to be_successful
      expect(Item.count).to eq(15)
      expect{Item.find(item1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  it 'renders error when id is not in database' do
    merchant = create(:merchant)
    item1 = Item.create!({name: "doomed_item", description: "doesn't matter", unit_price: 10, merchant_id: merchant.id})
    create_list(:item, 15)
    expect(Item.count).to eq(16)
    delete "/api/v1/items/#{22}"
    expect(response.status).to eq(404)
    expect(Item.count).to eq(16)
    delete "/api/v1/items/0"
    expect(response.status).to eq(404)
    expect(Item.count).to eq(16)
  end

  it 'destroys all the invoices related to the item' do
    Item.destroy_all
    merchant = create(:merchant)
    item1 = Item.create!({name: "doomed_item", description: "doesn't matter", unit_price: 10, merchant_id: merchant.id})
    create_list(:item, 15)
    create_list(:invoice, 10)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    invoice4 = create(:invoice)
    invoice5 = create(:invoice)
    invoice_item = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: Item.last.id, invoice_id: invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: Item.second_to_last.id, invoice_id: invoice5.id)

    expect(Item.count).to eq(16)
    delete "/api/v1/items/#{item1.id}"
    expect(response).to be_successful
    expect(Item.count).to eq(15)
    expect(Invoice.count).to eq(13)
    expect(InvoiceItem.count).to eq(2)
  end
end
