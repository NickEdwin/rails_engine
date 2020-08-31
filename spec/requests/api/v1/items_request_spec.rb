require 'rails_helper'

describe "Items API" do
  before(:each) do
    create(:merchant)
    @merchant = Merchant.first
    create_list(:item, 3, merchant: @merchant)
    @item = Item.last
    get '/api/v1/items'
  end

  it "sends a list of items" do

    get '/api/v1/items'

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it "can show an item" do
    get "/api/v1/items/#{@item.id}"

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["name"]).to eq(@item.name)
  end

  it "can create an item" do
    item_params = { name: "Magic Beans", description: "They grow large bean stalks!", unit_price: 1.99, merchant_id: @merchant.id }

    post '/api/v1/items', params: {item: item_params}

    expect(response).to be_successful
    expect(response.status).to eq(200)

    item = Item.last

    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
  end

  it "can update an item" do
    item_params = { name: "Magic Beans", description: "They grow large bean stalks!", unit_price: 1.99, merchant_id: @merchant.id }

    post '/api/v1/items', params: {item: item_params}

    item = Item.last

    item_params = { name: "Not Magic Beans", description: "They do not grow large bean stalks!", unit_price: 1.99, merchant_id: @merchant.id }

    patch "/api/v1/items/#{item.id}", params: {item: item_params}

    updated_item = Item.find(item.id)

    expect(updated_item.name).to_not eq("Magic Beans")
    expect(updated_item.name).to eq("Not Magic Beans")
    expect(updated_item.description).to_not eq("They grow large bean stalks!")
    expect(updated_item.description).to eq("They do not grow large bean stalks!")
  end

  it "can delete an item" do
    get '/api/v1/items'
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)

    item = Item.last

    delete "/api/v1/items/#{item.id}"

    get '/api/v1/items'
    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
  end
end
