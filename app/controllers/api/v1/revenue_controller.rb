class Api::V1::RevenueController < ApplicationController


  def most_revenue
    if params[:quantity]
      merchants = Merchant.find_top_merchants(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants)
    else
      render json: {error: {}}, status: 400
    end
  end

  def unshipped_revenue
    if params[:quantity].to_i <= 0 && !params[:quantity].nil?
      render json: {error: 'Invalid quantity'}, status: :bad_request
    else
      invoices = Invoice.find_unshipped_revenue(params[:quantity])
      render json: UnshippedOrderSerializer.new(invoices)
    end
  end

  def merchant_revenue
    if merchant = Merchant.find_revenue(params[:id]).empty?
      render json: {error: {}}, status: 404
    else
      merchant = Merchant.find_revenue(params[:id])
      render json: MerchantRevenueSerializer.new(merchant.first)
    end
  end

  def item_revenue
    if params[:quantity].to_i > 0 || params[:quantity].nil?
      items = Item.find_top_items(params[:quantity])
      render json: ItemRevenueSerializer.new(items)
    else
      render json: {error: 'Invalid quantity'}, status: 400
    end
  end

  def between_dates
    if params[:start].nil? || params[:end].nil? || params[:start].empty? || params[:end].empty?
      render json: {error: 'Provide both valid start and end date'}, status: 400
    else
      startdate = params[:start].to_time
      enddate = params[:end].to_time
      revenue = Merchant.across_dates(startdate, enddate)
      render json: RevenueSerializer.new(revenue).serialized_json
    end
  end
end
