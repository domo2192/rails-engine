class Api::V1::Items::SearchController < ApplicationController


  def find_all
    if params[:name] && (params[:max_price] || params[:min_price])
      render json: {error: {}}, status: 400
    elsif params[:max_price] && params[:min_price]
      items = Item.find_by_range_price(params[:max_price], params[:min_price])
      render json: ItemSerializer.new(items)
    elsif params[:min_price]
      items = Item.find_by_min_price(params[:min_price])
      render json: ItemSerializer.new(items)
    elsif params[:max_price]
      items = Item.find_by_max_price(params[:max_price])
      render json: ItemSerializer.new(items)
    elsif params[:name]
      items = Item.find_by_fragment(params[:name])
      render json: ItemSerializer.new(items)
    end
  end
end
