class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.collect_records(params[:per_page], params[:page])
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find_record(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item).serialized_json, status: :created
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
