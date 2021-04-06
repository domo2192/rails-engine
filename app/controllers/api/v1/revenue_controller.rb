class Api::V1::RevenueController < ApplicationController


  def show
    merchants = Merchant.find_top_merchants(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
