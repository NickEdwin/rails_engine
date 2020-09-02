class Api::V1::MerchantsSearchController < ApplicationController

  def show
    attribute = params.keys.first
    value = params[attribute]

    if  merchant_params.keys.first == "name"
      merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%").first
    else attribute == "created_at" || "updated_at"
      merchants = Merchant.all
      merchant = merchants.each do |merchant|
        "merchant.#{attribute}.to_date" == "#{value.to_date}"
      end
      merchant = merchant.first
    end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    attribute = params.keys.first
    value = params[attribute]

    if  merchant_params.keys.first == "name"
      merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%")
    else attribute == "created_at" || "updated_at"
      merchants = Merchant.all
      merchant = merchants.each do |merchant|
        "merchant.#{attribute}.to_date" == "#{value.to_date}"
      end
    end
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
