require 'rails_helper'

describe "Find API" do
  before(:each) do
    create(:merchant, name: "Ring World")
    create(:merchant, name: "Boats n Stuff")
    create(:merchant, name: "I Sell Food")
    create(:merchant, name: "Ring a Ding Ding")
    @merchant1 = Merchant.first
    @merchant2 = Merchant.last
    create(:item, name: "Banana", merchant: @merchant1)
    create(:item, name: "Apple", merchant: @merchant1)
    create(:item, name: "Banana Phone", merchant: @merchant2)
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
end
