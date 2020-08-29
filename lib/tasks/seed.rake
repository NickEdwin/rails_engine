require 'csv'

desc "Seeding database with CSV files"
task seed: :environment do

  puts "Resetting Database"

  Transaction.delete_all
  Invoice.delete_all
  Customer.delete_all
  Item.delete_all
  Merchant.delete_all
  InvoiceItem.delete_all

  puts "Database has been reset"

  CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
    Customer.create!({id: row[:id],
                      first_name: row[:first_name],
                      last_name: row[:last_name],
                      created_at: row[:created_at],
                      updated_at: row[:updated_at]})
  end
  puts "There are now #{Customer.count} cutomers in the database."

  CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
    Merchant.create!({id: row[:id],
                      name: row[:name],
                      created_at: row[:created_at],
                      updated_at: row[:updated_at]})
  end
  puts "There are now #{Merchant.count} merchants in the database."

  CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
    Item.create!({id: row[:id],
                  name: row[:name],
                  description: row[:description],
                  unit_price: row[:unit_price].to_f / 100,
                  merchant_id: row[:merchant_id],
                  created_at: row[:created_at],
                  updated_at: row[:updated_at]})
  end
  puts "There are now #{Item.count} items in the database."

  CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
    Invoice.create!({id: row[:id],
                     customer_id: row[:customer_id],
                     merchant_id: row[:merchant_id],
                     status: row[:status],
                     created_at: row[:created_at],
                     updated_at: row[:updated_at]})
  end
  puts "There are now #{Invoice.count} invoices in the database."

  CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
    Transaction.create!({id: row[:id],
                     invoice_id: row[:invoice_id],
                     credit_card_number: row[:credit_card_number],
                     credit_card_expiration_date: row[:credit_card_expiration_date],
                     result: row[:result],
                     created_at: row[:created_at],
                     updated_at: row[:updated_at]})
  end
  puts "There are now #{Transaction.count} transactions in the database."

  CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create!({id: row[:id],
                     item_id: row[:item_id],
                     invoice_id: row[:invoice_id],
                     quantity: row[:quantity],
                     unit_price: row[:unit_price].to_f / 100,
                     created_at: row[:created_at],
                     updated_at: row[:updated_at]})
  end
  puts "Database has been reset."
end
