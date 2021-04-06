class Api::V1::RevenueController < ApplicationController


  def show
    if params[:quantity]
      merchants = Merchant.find_top_merchants(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants)
    else
      render json: {error: {}}, status: 400
    end
  end
end
