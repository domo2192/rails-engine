require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  describe 'GET /api/v1/merchants/most_items?quantity' do
    it 'returns the merchants with most items sold and specify amount' do
      Merchant.destroy_all
      create_list(:merchant, 20)
      create_list(:item, 15, merchant: Merchant.first)
      create_list(:item, 15, merchant: Merchant.second)
      create_list(:item, 15, merchant: Merchant.third)
      create_list(:item, 15, merchant: Merchant.fourth)
      create_list(:item, 15, merchant: Merchant.last)
      create_list(:item, 15, merchant: Merchant.second_to_last)
      create_list(:item, 15, merchant: Merchant.third_to_last)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)
    invoice4 = create(:invoice)
    invoice5 = create(:invoice)
    invoice6 = create(:invoice)
    invoice7 = create(:invoice)
    invoice8 = create(:invoice)
    invoice_item1 = create(:invoice_item, item_id: Item.first.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
    invoice_item2 = create(:invoice_item, item_id: Item.second.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id: Item.third.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id: Item.last.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item5 = create(:invoice_item, item_id: Item.second_to_last.id, invoice_id:invoice5.id, quantity: 1, unit_price:2)
    invoice_item6 = create(:invoice_item, item_id: Item.last.id, invoice_id:invoice6.id, quantity: 10, unit_price:10)
    invoice_item7 = create(:invoice_item, item_id: Item.third_to_last.id, invoice_id:invoice7.id, quantity: 1, unit_price:1)
    invoice_item8 = create(:invoice_item, item_id: Item.third_to_last.id, invoice_id:invoice8.id, quantity: 1, unit_price: 1)
    # transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id,  cardit_card_expiration_date:  "04/23" )
    # transaction2 = create(:transaction, result: "success", invoice_id: invoice7.id,  cardit_card_expiration_date:  "04/23" )
    # transaction2 = create(:transaction, result: "success", invoice_id: invoice3.id,  cardit_card_expiration_date:  "04/23" )
    # transaction3 = create(:transaction, result: "success", invoice_id: invoice8.id,  cardit_card_expiration_date:  "04/23" )
    # transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id,  cardit_card_expiration_date:  "04/23" )
    # transaction5 = create(:transaction, result: "success", invoice_id: invoice5.id,  cardit_card_expiration_date:  "04/23" )
    # transaction8 = create(:transaction, result: "success", invoice_id: invoice6.id,  cardit_card_expiration_date:  "04/23" )
    # transaction8 = create(:transaction, result: "success", invoice_id: invoice7.id, cardit_card_expiration_date:  "04/23" )
    # transaction8 = create(:transaction, result: "success", invoice_id: invoice8.id, cardit_card_expiration_date:"04/23" )
      # create(:invoice, merchant: Merchant.first)
      # create(:invoice_item, item_id: Item.first, invoice_id:Invoice.first)
      get "/api/v1/merchants/most_items?quantity=2"
      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)

    end
  end
end
