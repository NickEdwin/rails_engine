class Api::V1::ItemsSearchController < ApplicationController

  def show
    attribute = params.keys.first
    value = params[attribute]

    if attribute == "name"
      item = Item.where("name ilike ?", "%#{value}%").first
    elsif attribute == "description"
      item = Item.where("description ilike ?", "%#{value}%").first
    elsif attribute == "unit_price"
      item = Item.where(unit_price: "#{value}.to_f").first
    else attribute == "created_at" || "updated_at"
      items = Item.all
      item = items.each do |item|
        "item.#{attribute}.to_date" == "#{value.to_date}"
      end
      item = item.first
    end
    render json: ItemSerializer.new(item)
  end

  def index
    attribute = params.keys.first
    value = params[attribute]

    if attribute == "name"
      item = Item.where("name ilike ?", "%#{value}%")
    elsif attribute == "description"
      item = Item.where("description ilike ?", "%#{value}%")
    elsif attribute == "unit_price"
      item = Item.where(unit_price: "#{value}.to_f")
    else attribute == "created_at" || "updated_at"
      items = Item.all
      item = items.each do |item|
        "item.#{attribute}.to_date" == "#{value.to_date}"
      end
    end
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end
end
