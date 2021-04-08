require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe 'GET /api/v1/items/item_id' do
    it 'returns the specific item when given the id' do
      create_list(:item, 15)
      item = Item.all.first
      get "/api/v1/items/#{item.id}"
      expect(response).to be_successful
      item_api = JSON.parse(response.body, symbolize_names: true)

      expect(item_api[:data][:attributes]).to have_key(:name)
      expect(item_api[:data][:attributes]).to have_key(:description)
      expect(item_api[:data][:attributes]).to have_key(:unit_price)
      expect(item_api[:data][:attributes]).to have_key(:merchant_id)
      expect(item_api[:data][:attributes]).to have_value(item.name)
      expect(item_api[:data][:attributes]).to have_value(item.description)
      expect(item_api[:data][:attributes]).to have_value(item.unit_price)
      expect(item_api[:data][:attributes]).to have_value(item.merchant_id)
    end

    it "returns 404 for sad path when id does not exist" do
      create_list(:item, 15)
      item = Item.all.first
      get "/api/v1/items/#{33}"
      expect(response).to_not be_successful
      expect(response.status).to be(404)
      get "/api/v1/items/33"
      expect(response).to_not be_successful
      expect(response.status).to be(404)
    end
  end

  it "returns 404 for string id " do
    create_list(:item, 15)
    item = Item.all.first
    get "/api/v1/items/1000"
    expect(response).to_not be_successful
    expect(response.status).to be(404)
    get "/api/v1/items/45"
    expect(response).to_not be_successful
    expect(response.status).to be(404)
  end
end
