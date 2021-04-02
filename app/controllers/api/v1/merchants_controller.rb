class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = Merchant.collect_records(params[:per_page], params[:page])
    render json: MerchantSerializer.new(merchants)
  end
end
