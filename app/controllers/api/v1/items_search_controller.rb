class Api::V1::ItemsSearchController < ApplicationController

  def show
    item = Item.where("name ilike ?", "%#{item_params[:name]}%").first
    render json: ItemSerializer.new(item)
  end

  def index
    item = Item.where("name ilike ?", "%#{item_params[:name]}%")
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description, :created_at, :updated_at)
  end
end
