require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants/merchant_id' do
    it 'returns the specific merchant when given the id' do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/#{merchant1.id}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes]).to have_value(Merchant.first.name)
    end

    it "returns 404 if id does not exist or is a string" do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/55"
      expect(response).not_to be_successful
        get "/api/v1/merchants/#{0}"
        expect(response).not_to be_successful
    end
  end
end
