class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :transactions, through: :invoices

  def self.most_revenue(result_length)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result='success' AND invoices.status='shipped'")
      .group(:id)
      .order('revenue DESC')
      .limit(result_length)
  end

  def self.most_items(result_length)
    select("merchants.*, SUM(invoice_items.quantity) AS sold")
      .joins(invoices: [:invoice_items, :transactions])
      .where("transactions.result='success' AND invoices.status='shipped'")
      .group(:id)
      .order('sold DESC')
      .limit(result_length)
  end

  # def self.revenue(start, ends)
  #   start = DateTime.parse(params[:start])
  #   ends = DateTime.parse(params[:end])
  #   require"pry"; binding.pry
  #
  #   select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
  #     .joins(invoices: [:invoice_items, :transactions])
  #     .where("transactions.result='success' AND invoices.status='shipped'")
  #     .where("transactions.created_at >= '#{start}' AND transactions.created_at <= '#{ends}'")
  #     .group(:id)
  # end
end
