require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  FactoryBot.create_list(:merchant, 40)
  describe 'GET /api/v1/merchants' do
		before {get '/api/v1/merchants'}
    it 'returns 20 merchants at a time without query params' do
			expect(json).not_to be_empty
			expect(json["data"].size).to eq(20)
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end
	end
end
