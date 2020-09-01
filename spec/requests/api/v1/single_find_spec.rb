require 'rails_helper'

describe "Find API" do
  before(:each) do
    create(:merchant, name: "Ring World")
    create(:merchant, name: "Boats n Stuff")
    create(:merchant, name: "I Sell Food")
    create(:merchant, name: "Ring a Ding Ding")
    @merchant1 = Merchant.first
    @merchant2 = Merchant.last
  end

  it "can find first merchant matching a name" do
    get '/api/v1/merchants/find?name=ring'


    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(@merchant1.name)
    expect(merchant["data"]["attributes"]["name"]).to_not eq(@merchant2.name)
  end
end
