require 'rails_helper'

describe "Business endpoint API" do
  before(:each) do
    @customer1 = Customer.create!(first_name: "Timmy", last_name: "Timmerson")
    @customer2 = Customer.create!(first_name: "Robert", last_name: "Robberson")

    @merchant1 = Merchant.create!(name: "Ring World")
    @merchant2 = Merchant.create!(name: "Boats n Stuff")
    @merchant3 = Merchant.create!(name: "I Sell Food")
    @merchant4 = Merchant.create!(name: "Ring a Ding Ding")

    @item1 = create(:item, name: "Banana", merchant: @merchant1, unit_price: 1)
    @item2 = create(:item, name: "Apple", merchant: @merchant1, unit_price: 2)
    @item3 = create(:item, name: "Lemon", merchant: @merchant2, unit_price: 3)
    @item4 = create(:item, name: "Pineapple", merchant: @merchant3, unit_price: 4)

    @invoice1 = @merchant1.invoices.create!(customer: @customer1, status: "shipped")
    @invoice2 = @merchant2.invoices.create!(customer: @customer1, status: "shipped")
    @invoice3 = @merchant3.invoices.create!(customer: @customer2, status: "shipped")
    @invoice4 = @merchant4.invoices.create!(customer: @customer2, status: "shipped")

    @invoice1.invoice_items.create!(item: @item1, quantity: 1, unit_price: 1)
    @invoice2.invoice_items.create!(item: @item2, quantity: 2, unit_price: 2)
    @invoice3.invoice_items.create!(item: @item3, quantity: 3, unit_price: 3)
    @invoice4.invoice_items.create!(item: @item4, quantity: 4, unit_price: 4)

    @invoice1.transactions.create!(credit_card_number: 4654405418249632, result: 'success')
    @invoice2.transactions.create!(credit_card_number: 4654405418249633, result: 'success')
    @invoice3.transactions.create!(credit_card_number: 4654405418249634, result: 'success')
    @invoice3.transactions.create!(credit_card_number: 4654405418249635, result: 'success')
  end

  it "can find variable number of merchants with the most revenue" do
    get "/api/v1/merchants/most_revenue?quantity=2"

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["name"]).to eq("I Sell Food")

    get "/api/v1/merchants/most_revenue?quantity=3"

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it "can find variable number of merchants with the most items_sold" do
    get "/api/v1/merchants/most_items?quantity=2"

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["name"]).to eq("I Sell Food")

    get "/api/v1/merchants/most_items?quantity=3"

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  # it "can find revenue for merchants accross a date range" do
  #   get "/api/v1/revenue?start=2019-03-09&end=2021-03-24"
  #
  #
  #
  # end
end
