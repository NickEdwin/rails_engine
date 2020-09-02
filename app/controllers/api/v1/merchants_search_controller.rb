class Api::V1::MerchantsSearchController < ApplicationController

  def show
    if  merchant_params.keys[0] == "name"
      merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%").first
    elsif merchant_params.keys[0] == "created_at"
      merchants = Merchant.all
      merchant = merchants.each do |merchant|
        merchant.created_at.to_date == merchant_params[:created_at].to_date
      end
      merchant = merchant[0]
    else
      merchants = Merchant.all
      merchant = merchants.each do |merchant|
        merchant.updated_at.to_date == merchant_params[:updated_at].to_date
      end
      merchant = merchant[0]
    end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    if  merchant_params.keys[0] == "name"
      merchant = Merchant.where("name ilike ?", "%#{merchant_params[:name]}%")
    elsif merchant_params.keys[0] == "created_at"
      merchants = Merchant.all
      merchant = merchants.each do |merchant|
        merchant.created_at.to_date == merchant_params[:created_at].to_date
      end
    else
      merchants = Merchant.all
      merchant = merchants.each do |merchant|
        merchant.updated_at.to_date == merchant_params[:updated_at].to_date
      end
    end
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
