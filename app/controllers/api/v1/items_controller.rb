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

  def update
    old_item = Item.find(params[:id])
    old_item.update!(item_params)
    render json: ItemSerializer.new(old_item).serialized_json
  end

  def destroy
    item = Item.find(params[:id])
    item.find_single_invoices
    render json: Item.destroy(params[:id])
  end


  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
