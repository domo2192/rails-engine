class Api::V1::MerchantitemsController < ApplicationController

  def show
     merchant = Merchant.find(params[:merchant_id])
     render json: ItemSerializer.new(merchant.items)
  end
end
