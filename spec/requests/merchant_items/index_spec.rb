require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants/merchnat_id' do
    it 'returns the specific merchant when given the id' do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/merchants/#{merchant1.id}/items"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      items.each do |item|
        expect(item[1][0][:attributes]).to have_key(:name)
        expect(item[1][0][:attributes]).to have_key(:description)
        expect(item[1][0][:attributes]).to have_key(:unit_price)
        expect(item[1][0][:attributes]).to have_key(:merchant_id)
        expect(item[1][0][:attributes][:merchant_id]).to eq(merchant1.id)
      end

    end
  end

  it 'has the correct data types' do
    Merchant.destroy_all
    Item.destroy_all
    merchant1 = create(:merchant)
    create_list(:item, 15, merchant: merchant1)
    get "/api/v1/merchants/#{merchant1.id}/items"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)
    items.each do |item|
      expect(item[1][0][:attributes][:name]).to be_a(String)
      expect(item[1][0][:attributes][:description]).to be_a(String)
      expect(item[1][0][:attributes][:unit_price]).to be_a(Float)
      expect(item[1][0][:attributes][:merchant_id]).to be_a(Integer)
    end

  end
end
