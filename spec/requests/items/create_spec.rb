require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe 'POST /api/v1/items' do
    it 'creates an item' do
      create_list(:item, 15)
      merchant = create(:merchant)
      item = ({name: "new_item", description: "best_item", unit_price: 35, merchant_id: merchant.id})
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/items", headers: headers, params: JSON.generate(item: item)
      expect(response).to have_http_status :created
      item_api = JSON.parse(response.body, symbolize_names: true)
      expect(item_api[:data][:id].to_i).to eq(Item.all.last.id)
      expect(item_api[:data][:attributes]).to have_key(:name)
      expect(item_api[:data][:attributes]).to have_key(:description)
      expect(item_api[:data][:attributes]).to have_key(:unit_price)
      expect(item_api[:data][:attributes]).to have_key(:merchant_id)
      expect(item_api[:data][:attributes]).to have_value(item[:name])
      expect(item_api[:data][:attributes]).to have_value(item[:description])
      expect(item_api[:data][:attributes]).to have_value(item[:unit_price])
      expect(item_api[:data][:attributes]).to have_value(item[:merchant_id])
    end

  it "renders 404 for invalid params" do
    create_list(:item, 15)
    merchant = create(:merchant)
    item = ({description: "best_item", unit_price: 35, merchant_id: merchant.id})
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item)
    expect(response).not_to have_http_status :created
    expect(response.status).to eq(404)
  end

    it "renders correct data when created" do
      Item.destroy_all
      create_list(:item, 15)
      merchant = create(:merchant)
      item = ({name: "value1", description: "value2", unit_price: 100.99, merchant_id: merchant.id})
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/items", headers: headers, params: JSON.generate(item: item)
      expect(response).to have_http_status :created
      expect(response.status).to eq(201)
      data = { "name": "value1","description": "value2","unit_price": 100.99, "merchant_id": merchant.id}
      item = JSON.parse(response.body, symbolize_names: true)
      expect(item[:data][:attributes]).to eq(data)
    end
  end
end
