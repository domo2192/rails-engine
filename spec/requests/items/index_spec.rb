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
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
		end

    it "returns page 1 if page 0 is entered" do
      FactoryBot.create_list(:item, 30)
      get '/api/v1/items?page=0?'
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items).not_to be_empty
      expect(items[:data].count).to eq(20)
      expect(items[:data].first[:attributes].values).to eq([Item.first.name, Item.first.description, Item.first.unit_price, Item.first.merchant_id])
      expect(items[:data].last[:attributes].values).to eq([Item.all[19].name, Item.all[19].description, Item.all[19].unit_price, Item.all[19].merchant_id])
    end


    it "returns the correct amount of data and on each page" do
      FactoryBot.create_list(:item, 100)
      get '/api/v1/items?per_page=50&page=2'
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items).not_to be_empty
      expect(items[:data].count).to eq(50)
      expect(items[:data].first[:attributes].values).to eq([Item.all[50].name, Item.all[50].description, Item.all[50].unit_price, Item.all[50].merchant_id])
      expect(items[:data].last[:attributes].values).to eq([Item.all[99].name, Item.all[99].description, Item.all[99].unit_price, Item.all[99].merchant_id])
    end 
  end
end
