require 'rails_helper'

RSpec.describe 'items search API', type: :request do
  describe 'GET /api/v1/items' do
    it 'returns all the items that match a search critation' do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/items/find_all?max_price=50"
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
      get "/api/v1/items/find_all?min_price=50"
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

    it "returns based on both query params" do
      merchant1 = create(:merchant)
      create_list(:item, 15, merchant: merchant1, unit_price: 35.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 90.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 70.0)
      create_list(:item, 15, merchant: merchant1, unit_price: 25.0)
      create_list(:item, 15, merchant: merchant1)
      get "/api/v1/items/find_all?max_price=50&min_price=20"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(30)
    end
  end

  it "can search by name fragment" do
    merchant1 = create(:merchant)
    item1 = create(:item, name:"Ringing")
    item1 = create(:item, name:"Turing")
    item1 = create(:item, name:"auringding")
    item1 = create(:item, name:"singringding")
    create_list(:item, 15, name:"not", merchant: merchant1, unit_price: 35.0)
    create_list(:item, 15, name: "the", merchant: merchant1, unit_price: 90.0)
    create_list(:item, 15, name: "correct", merchant: merchant1, unit_price: 70.0)
    create_list(:item, 15, name: "name", merchant: merchant1, unit_price: 25.0)
    create_list(:item, 15, name: "almosting", merchant: merchant1)
      get "/api/v1/items/find_all?name=ring"
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].size).to eq(4)
  end

  it "will error out if you pass both the name and range" do
    merchant1 = create(:merchant)
    item1 = create(:item, name:"Ringing")
    item1 = create(:item, name:"Turing")
    item1 = create(:item, name:"auringding")
    item1 = create(:item, name:"singringding")
    create_list(:item, 15, name:"not", merchant: merchant1, unit_price: 35.0)
    create_list(:item, 15, name: "the", merchant: merchant1, unit_price: 90.0)
    create_list(:item, 15, name: "correct", merchant: merchant1, unit_price: 70.0)
    create_list(:item, 15, name: "name", merchant: merchant1, unit_price: 25.0)
    create_list(:item, 15, name: "almosting", merchant: merchant1)
      get "/api/v1/items/find_all?name=ring&min_price=20"
      expect(response).not_to be_successful
  end

  it " will error if you pass max price do " do
    merchant1 = create(:merchant)
    item1 = create(:item, name:"Ringing")
    item1 = create(:item, name:"Turing")
    item1 = create(:item, name:"auringding")
    item1 = create(:item, name:"singringding")
    create_list(:item, 15, name:"not", merchant: merchant1, unit_price: 35.0)
    create_list(:item, 15, name: "the", merchant: merchant1, unit_price: 90.0)
    create_list(:item, 15, name: "correct", merchant: merchant1, unit_price: 70.0)
    create_list(:item, 15, name: "name", merchant: merchant1, unit_price: 25.0)
    create_list(:item, 15, name: "almosting", merchant: merchant1)
      get "/api/v1/items/find_all?name=ring&max_price=20"
      expect(response).not_to be_successful
  end

  it "will error if you pass both do " do
    merchant1 = create(:merchant)
    item1 = create(:item, name:"Ringing")
    item1 = create(:item, name:"Turing")
    item1 = create(:item, name:"auringding")
    item1 = create(:item, name:"singringding")
    create_list(:item, 15, name:"not", merchant: merchant1, unit_price: 35.0)
    create_list(:item, 15, name: "the", merchant: merchant1, unit_price: 90.0)
    create_list(:item, 15, name: "correct", merchant: merchant1, unit_price: 70.0)
    create_list(:item, 15, name: "name", merchant: merchant1, unit_price: 25.0)
    create_list(:item, 15, name: "almosting", merchant: merchant1)
      get "/api/v1/items/find_all?name=ring&max_price=20&min_price=50"
      expect(response).not_to be_successful
  end
end
