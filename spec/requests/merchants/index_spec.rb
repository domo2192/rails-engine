require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants' do
    it 'returns 20 merchants at a time without query params' do
      FactoryBot.create_list(:merchant, 20)
      get '/api/v1/merchants'
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
			expect(merchants).not_to be_empty
			expect(merchants[:data].count).to eq(20)
      merchants[:data].each do |merchant|
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
		end

		it 'returns status code 200' do
       get '/api/v1/merchants'
			expect(response).to have_http_status(200)
		end
	end

  it 'can return less than 20' do
     create_list(:merchant, 5)
     get '/api/v1/merchants?per_page=3'

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(3)
  end

  it 'can be longer than 20' do
    create_list(:merchant, 30)
     get '/api/v1/merchants?per_page=30'
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(30)
  end
end
