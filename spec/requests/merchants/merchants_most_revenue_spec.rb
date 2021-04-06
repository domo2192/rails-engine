require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants/most_revenue?quantity' do
    it 'returns the merchants with most revenue and specify amount' do
      create_list(:merchant, 20)
      create_list(:item, 15, merchant: Merchant.first)
      get "/api/v1/merchants/most_revenue?quantity=3"
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)

    end
  end
end
