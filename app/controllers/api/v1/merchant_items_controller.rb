class Api::V1::MerchantItemsController < ApplicationController

  def show
     merchant = Merchant.find(params[:merchant_id])
     render json: ItemSerializer.new(merchant.items.all)
  end
end
