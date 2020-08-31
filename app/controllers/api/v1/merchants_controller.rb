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

  def destroy
    id = params[:id]
    render json: MerchantSerializer.new(Merchant.find(id))
    Merchant.delete(id)
  end

  def items_index
    id = params[:merchant_id]
    render json: ItemSerializer.new(Item.where(merchant_id: id))
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
