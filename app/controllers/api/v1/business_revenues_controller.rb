class Api::V1::BusinessRevenuesController < ApplicationController
  def index
    result_length = params[:quantity].to_i
    merchants = Merchant.most_revenue(result_length)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    result_length = params[:quantity].to_i
    merchants = Merchant.most_items(result_length)
    render json: MerchantSerializer.new(merchants)
  end

  # def revenue
  #   merchants = Merchant.revenue(start, ends)
  #   render json: MerchantSerializer.new(merchants)
  # end
end
