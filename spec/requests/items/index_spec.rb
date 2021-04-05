require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  describe 'GET /api/v1/items' do
    it 'returns 20 items at a time without query params' do
      FactoryBot.create_list(:item, 30)
      get '/api/v1/items'
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
			expect(items).not_to be_empty
			expect(items[:data].count).to eq(20)
      items[:data].each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:id)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:id]).to be_a(Integer)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
		end
  end

  
end
