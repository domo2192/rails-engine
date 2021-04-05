class Api::V1::ItemsController < ApplicationController

  def index
    items = Item.collect_records(params[:per_page], params[:page])
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find_record(params[:id])
    render json: ItemSerializer.new(item)
  end
end
