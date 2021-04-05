require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/items/item_id/merchant_id' do
    it 'returns the specific merchant of an item' do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/items/#{Item.first.id}/merchant"
      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to eq(merchant1.name)
    end
  end
end
