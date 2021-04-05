require 'rails_helper'

RSpec.describe 'items search API', type: :request do
  describe 'GET /api/v1/items' do
    it 'returns all the items that match a search critation' do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/find_all?max_price=50"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(30)
      items[:data].each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end
    end

    it "returns all the items based on a minimum price" do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/find_all?min_price=50"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(15)
      items[:data].each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end
    end

    it "returns based on both query params " do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 70.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 25.0)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/find_all?max_price=50&min_price=20"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(30)
    end
  end
end
