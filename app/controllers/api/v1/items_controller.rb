class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params))
  end

  def update
    id = params[:id]
    render json: ItemSerializer.new(Item.update(id, item_params))
  end

  def destroy
    id = params[:id]
    render json: ItemSerializer.new(Item.find(id))
    Item.delete(id)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
