require 'rails_helper'

describe "Find API" do
  before(:each) do
    create(:merchant, name: "Ring World")
    create(:merchant, name: "Boats n Stuff")
    create(:merchant, name: "I Sell Food")
    create(:merchant, name: "Ring a Ding Ding")
    @merchant1 = Merchant.first
    @merchant2 = Merchant.last
    create(:item, name: "Banana", description: "It is food", unit_price: 1.00, merchant: @merchant1)
    create(:item, name: "Apple", merchant: @merchant1)
    create(:item, name: "Banana Phone", description: "It is not food", unit_price: 1.00, merchant: @merchant2)
    @item1 = Item.first
    @item2 = Item.last
  end

  it "can find first merchant matching a name" do
    get '/api/v1/merchants/find?name=ring'

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchant["data"]["attributes"]["name"]).to_not eq(@merchant2.name)
  end

  it "can find first item matching a name" do
    get '/api/v1/items/find?name=banana'

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"]["attributes"]["name"]).to_not eq(@item2.name)
  end

  it "can find all merchants matching a name" do
    get '/api/v1/merchants/find_all?name=ring'

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchants["data"][1]["attributes"]["name"]).to eq(@merchant2.name)
  end

  it "can find all items matching a name" do
    get '/api/v1/items/find_all?name=banana'

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["name"]).to eq(@item1.name)
    expect(items["data"][1]["attributes"]["name"]).to eq(@item2.name)
  end

  it "can find first item matching a description" do
    get '/api/v1/items/find?description=food'

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"]["attributes"]["name"]).to_not eq(@item2.name)
  end

  it "can find all items matching a description" do
    get '/api/v1/items/find_all?description=food'

    items = JSON.parse(response.body)
    expect(items["data"][0]["attributes"]["name"]).to eq(@item1.name)
    expect(items["data"][1]["attributes"]["name"]).to eq(@item2.name)
  end

  it "can find first item matching a price" do
    get '/api/v1/items/find?unit_price=1'

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"]["attributes"]["name"]).to_not eq(@item2.name)
  end

  it "can find all items matching a price" do
    get '/api/v1/items/find_all?unit_price=1'

    item = JSON.parse(response.body)
    expect(item["data"][0]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"][1]["attributes"]["name"]).to eq(@item2.name)
  end

  it "can find first item matching a creation date" do
    get "/api/v1/items/find?created_at=#{@item1.created_at}"

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"]["attributes"]["name"]).to_not eq(@item2.name)
  end

  it "can find all items matching a creation date" do
    get "/api/v1/items/find_all?created_at=#{@item1.created_at}"

    item = JSON.parse(response.body)
    expect(item["data"][0]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"][2]["attributes"]["name"]).to eq(@item2.name)
  end

  it "can find first item matching a updated date" do
    get "/api/v1/items/find?updated_at=#{@item1.updated_at}"

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"]["attributes"]["name"]).to_not eq(@item2.name)
  end

  it "can find all items matching a updated date" do
    get "/api/v1/items/find_all?updated_at=#{@item1.updated_at}"

    item = JSON.parse(response.body)
    expect(item["data"][0]["attributes"]["name"]).to eq(@item1.name)
    expect(item["data"][2]["attributes"]["name"]).to eq(@item2.name)
  end

  it "can find first merchant matching a creation date" do
    get "/api/v1/merchants/find?created_at=#{@merchant1.created_at}"

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchant["data"]["attributes"]["name"]).to_not eq(@merchant2.name)
  end

  it "can find all merchants matching a creation date" do
    get "/api/v1/merchants/find_all?created_at=#{@merchant1.created_at}"

    merchant = JSON.parse(response.body)
    expect(merchant["data"][0]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchant["data"][3]["attributes"]["name"]).to eq(@merchant2.name)
  end

  it "can find first merchant matching an update date" do
    get "/api/v1/merchants/find?updated_at=#{@merchant1.updated_at}"

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchant["data"]["attributes"]["name"]).to_not eq(@merchant2.name)
  end

  it "can find first merchant matching an update date" do
    get "/api/v1/merchants/find_all?updated_at=#{@merchant1.updated_at}"

    merchant = JSON.parse(response.body)
    expect(merchant["data"][0]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchant["data"][3]["attributes"]["name"]).to eq(@merchant2.name)
  end
end
