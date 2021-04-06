class Api::V1::Merchants::SearchController < ApplicationController

  def find_one
    merchant = Merchant.find_by_fragment(params[:name]).order('name ASC')
    if merchant.empty?
      render json: MerchantSerializer.convert(merchant)
    else
      render json: MerchantSerializer.new(merchant.first)
    end
  end

end
