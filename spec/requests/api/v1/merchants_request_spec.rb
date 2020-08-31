require 'rails_helper'

describe "Merchants API" do
  before(:each) do
    create_list(:merchant, 5)
    get '/api/v1/merchants'
  end

  it "sends a list of merchants" do

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(5)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it "can create a merchant" do
    merchant_params = { name: "Toys R Us" }

    post '/api/v1/merchants', params: {merchant: merchant_params}

    expect(response).to be_successful
    expect(response.status).to eq(200)

    merchant = Merchant.last

    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update a mercchant" do
    merchant_params = { name: "Toys R Us" }

    post '/api/v1/merchants', params: {merchant: merchant_params}

    merchant = Merchant.last

    merchant_params = { name: "Toys R  No Longer Us" }

    patch "/api/v1/merchants/#{merchant.id}", params: {merchant: merchant_params}

    updated_merchant = Merchant.find(merchant.id)

    expect(updated_merchant.name).to_not eq("Toys R Us")
    expect(updated_merchant.name).to eq("Toys R  No Longer Us")
  end
end
