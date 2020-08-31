class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def create
    render json: Item.create(item_params)
  end

  def update
    item = Item.find(params[:id])
    render json: item.update(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
