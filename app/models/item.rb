class Item < ApplicationRecord
  validates :name, :description, :unit_price, presence: true

  belongs_to :merchant, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
end
