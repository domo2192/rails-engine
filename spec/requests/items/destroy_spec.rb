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
    expect(response.status).to eq(200)
    expect(Item.count).to eq(16)
    delete "/api/v1/items/0"
    expect(response.status).to eq(200)
    expect(Item.count).to eq(16)
  end
end
