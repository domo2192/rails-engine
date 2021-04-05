class Api::V1::Items::SearchController < ApplicationController


  def find_all
    if params[:max_price] && params[:min_price]
      items = Item.find_by_range_price(params[:max_price], params[:min_price])
    elsif params[:min_price]
      items = Item.find_by_min_price(params[:min_price])
    elsif params[:max_price]
      items = Item.find_by_max_price(params[:max_price])
    elsif params[:name]
      items = Item.find_by_fragment(params[:name])
    end
    render json: ItemSerializer.new(items)
  end
end
