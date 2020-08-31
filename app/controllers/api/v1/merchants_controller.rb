class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    id = params[:id]
    render json: MerchantSerializer.new(Merchant.update(id, merchant_params))
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
