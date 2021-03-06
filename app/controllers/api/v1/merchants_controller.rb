class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = Merchant.collect_records(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find_record(params[:id])
    render json: MerchantSerializer.new(merchant)
  end

  def most_items
    if params[:quantity].nil? || params[:quantity].empty?
      render json: {error: {}}, status: 400
    else
      merchants = Merchant.most_items_sold(params[:quantity])
      render json: MerchantItemCountSerializer.new(merchants)
    end
  end
end
