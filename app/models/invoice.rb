class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer, dependent: :destroy
  belongs_to :merchant, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
end
