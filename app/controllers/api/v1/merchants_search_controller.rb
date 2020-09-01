class Api::V1::MerchantsSearchController < ApplicationController

  def show
    merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%").first
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%")
    render json: MerchantSerializer.new(merchant)
  end

  private

    def merchant_params
      params.permit(:name, :created_at, :updated_at)
    end
end
