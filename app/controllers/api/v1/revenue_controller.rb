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
    invoices = Invoice.find_unshipped_revenue(params[:quantity])
    render json: UnshippedOrderSerializer.new(invoices)
  end

  def merchant_revenue
    if merchant = Merchant.find_revenue(params[:id]).empty?
      render json: {error: {}}, status: 404
    else
      merchant = Merchant.find_revenue(params[:id])
      render json: MerchantRevenueSerializer.new(merchant.first)
    end
  end

  # def index
  #   if params[:start] && params[:end]
  #     revenue = Merchant.revenue_between(params[:start], params[:end])
  #     require "pry"; binding.pry
  #   else
  #     render json: {error: {}}, status: 400
  #   end
  # end
end
