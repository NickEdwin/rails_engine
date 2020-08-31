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
end
