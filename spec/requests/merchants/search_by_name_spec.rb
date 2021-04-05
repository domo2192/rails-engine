require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants/merchant_id' do
    it 'returns the specific merchant when given the name' do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/find?name=#{merchant1.name}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes]).to have_value(merchant1.name)
    end

    it "returns a merchant if a bunch are similar names" do
      Merchant.destroy_all
      merchant1 = create(:merchant, name: "better merchant")
      create_list(:merchant, 15, name: "Best Merchants")
        get "/api/v1/merchants/find?name=better"
        expect(response).to be_successful
        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(merchant[:data][:attributes]).to have_value(merchant1.name)
        expect(merchant[:data][:attributes]).not_to have_value(Merchant.last.name)
    end

    it "returns first by alphabetical order" do
      Merchant.destroy_all
      merchant1 = create(:merchant, name: "Turing")
      merchant2 = create(:merchant, name: "Ring World")
      get "/api/v1/merchants/find?name=ring"
      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(merchant[:data][:attributes]).to have_value(merchant2.name)
      expect(merchant[:data][:attributes]).not_to have_value(merchant1.name)
    end

    it "returns a object for sad path no fragment matches " do
      Merchant.destroy_all
      create_list(:merchant, 15, name: "Best Merchants")
        get "/api/v1/merchants/find?name=ring"
        expect(response).to be_successful
        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(merchant[:data].class).to be(Hash)
    end
  end
end
