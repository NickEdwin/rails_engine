require 'rails_helper'

describe "Items API" do
  before(:each) do
    create(:merchant)
    @merchant = Merchant.first
  end

  it "sends a list of items" do
    create_list(:item, 3, merchant: @merchant)

    get '/api/v1/items'

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)

    expect(response).to be_successful
    expect(response.status).to eq(200)
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
end
