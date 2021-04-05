require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe 'Put /api/v1/items/id' do
    it 'updates an item' do
      create_list(:item, 15)
      merchant = create(:merchant)
      item1 = Item.all.first
      item_update = ({name: "update_item", description: "update_item", unit_price: 45, merchant_id: merchant.id})
      headers = {"CONTENT_TYPE" => "application/json"}
      put "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate(item: item_update)
      expect(response.status).to eq(200)
      updated_item = JSON.parse(response.body, symbolize_names: true)
      expect(updated_item[:data][:id].to_i).to eq(item1.id)
      expect(updated_item[:data][:attributes][:name]).not_to eq(item1.name)

      end
    end
  end
