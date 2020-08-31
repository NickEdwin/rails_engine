require 'rails_helper'

describe "Merchant & items API" do
  before(:each) do
    create_list(:merchant, 2)
    @merchant1 = Merchant.first
    @merchant2 = Merchant.last
    create_list(:item, 3, merchant: @merchant1)
    create_list(:item, 1, merchant: @merchant2)
    @item = Item.first
    get '/api/v1/items'
  end

  it "sends a list of items for a single merchant" do

    get "/api/v1/merchants/#{@merchant1.id}/items"

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it "sends a merchant who sells that item" do

    get "/api/v1/items/#{@item.id}/merchant"
    
    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(@merchant1.name)
  end
end
