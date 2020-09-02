class Api::V1::ItemsSearchController < ApplicationController

  def show
    if item_params.keys[0] == "name"
      item = Item.where("name ilike ?", "%#{item_params[:name]}%").first
    elsif item_params.keys[0] == "description"
      item = Item.where("description ilike ?", "%#{item_params[:description]}%").first
    elsif item_params.keys[0] == "unit_price"
      item = Item.where(unit_price: "#{item_params[:unit_price]}.to_f").first
    elsif item_params.keys[0] == "created_at"
      items = Item.all
      item = items.each do |item|
        item.created_at.to_date == item_params[:created_at].to_date
      end
      item = item[0]
    else
      items = Item.all
      item = items.each do |item|
        item.updated_at.to_date == item_params[:updated_at].to_date
      end
      item = item[0]
    end
    render json: ItemSerializer.new(item)
  end

  def index
    if item_params.keys[0] == "name"
      items = Item.where("name ilike ?", "%#{item_params[:name]}%")
    elsif item_params.keys[0] == "description"
      items = Item.where("description ilike ?", "%#{item_params[:description]}%")
    elsif item_params.keys[0] == "unit_price"
      items = Item.where(unit_price: "#{item_params[:unit_price]}.to_f")
    elsif item_params.keys[0] == "created_at"
      items = Item.all
      items = items.each do |item|
        item.created_at.to_date == item_params[:created_at].to_date
      end
    else
      items = Item.all
      items = items.each do |item|
        item.updated_at.to_date == item_params[:updated_at].to_date
      end
    end
    render json: ItemSerializer.new(items)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end
end
