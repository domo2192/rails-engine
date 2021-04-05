class Api::V1::Merchants::SearchController < ApplicationController

  def find_one
    merchant = Merchant.find_by_fragment(params[:name]).order('name ASC')
    if merchant.empty?
      render json: MerchantSerializer.convert(merchant)
    else
      render json: MerchantSerializer.new(merchant.first)
    end
  end

  def find_all
    if params[:max_price] && params[:min_price]
      items = Item.find_by_range_price(params[:max_price], params[:min_price])
    elsif params[:min_price]
      items = Item.find_by_min_price(params[:min_price])
    elsif params[:max_price]
      items = Item.find_by_max_price(params[:max_price])
    end
    render json: ItemSerializer.new(items)
  end
end
