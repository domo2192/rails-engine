class Api::V1::Merchants::SearchController < ApplicationController

  def find
    merchant = Merchant.find_by_fragment(params[:name])
    render json: MerchantSerializer.new(merchant.first)
  end
end
